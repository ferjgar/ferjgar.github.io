---
id: 774
title: Conflicto de herencia en htaccess entre Rewrite y Auth
date: 2010-09-23T12:26:01+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=774
permalink: /desarrollo/conflicto-de-herencia-en-htaccess-entre-rewrite-y-auth
categories:
  - Desarrollo
tags:
  - apache
---
Atención al titulo, soy un hacha jugando con keywords para atraer a todo tipo de audiencia al blog&#8230; y no, no se ha muerto Apache y los módulos se pelean por la pasta&#8230; en fin, al turrón. Pongamos que tenemos una web http://www.pepe.com, que en el servidor corresponde al path _/home/web/pepe_, y un subdirectorio http://www.pepe.com/admin, cuya ruta es _/home/web/pepe/admin_.

En mi caso concreto pepe.com es un dominio antiguo, y quiero que toda referencia a él acabe en el nuevo, digamos paco.com. Para ello utilizo un htaccess que hace una redirección 301 a lo bruto:

<div class="codecolorer-container apache twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="apache codecolorer">
    <span class="co1"># colocado en /home/web/pepe/.htaccess</span><br /> <span class="kw1">Options</span> +<span class="kw2">FollowSymlinks</span><br /> <span class="kw1">RewriteEngine</span> <span class="kw2">on</span><br /> <span class="kw1">RewriteRule</span> ^(.*)$ http://www.paco.com [R=<span class="nu0">301</span>,L]
  </div>
</div>

Éste es mi problema concreto, pero por ejemplo es también muy común en frameworks y CMS hacer una redirección general de todas las peticiones a un único fichero. Vamos, que aquí lo importante es la **reescritura general**.

Ahora lo que quiero es **proteger con contraseña** el acceso a mi administración, por lo que utilizo otro htaccess con el contenido estándar para ésto:

<div class="codecolorer-container apache twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="apache codecolorer">
    <span class="co1"># colocado en /home/web/pepe/admin/.htaccess</span><br /> <span class="kw1">AuthType</span> Basic<br /> <span class="kw1">AuthUserFile</span> /home/web/pepe/admin/.htpasswd<br /> <span class="kw1">AuthName</span> <span class="st0">"Acceso Administrador"</span><br /> <span class="kw1">Require</span> valid-<span class="kw1">user</span>
  </div>
</div>

Y como no podía ser de otra forma el invento no funciona. Cuando intento acceder a http://www.pepe.com/admin me redirige a http://www.paco.com, luego el primer cambio es meter una excepción para que no aplique la regla de reescritura para la URL que nos interesa. Lo podemos hacer en el htaccess principal con una condición:

<div class="codecolorer-container apache twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="apache codecolorer">
    <span class="co1"># colocado en /home/web/pepe/.htaccess</span><br /> <span class="kw1">Options</span> +<span class="kw2">FollowSymlinks</span><br /> <span class="kw1">RewriteEngine</span> <span class="kw2">on</span><br /> <span class="kw1">RewriteCond</span> %{REQUEST_URI} !^/admin/?<br /> <span class="kw1">RewriteRule</span> ^(.*)$ http://www.paco.com [R=<span class="nu0">301</span>,L]
  </div>
</div>

O si no necesitamos de ninguna reescritura en el directorio hijo podemos directamente desactivar el engine:

<div class="codecolorer-container apache twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="apache codecolorer">
    <span class="co1"># colocado en /home/web/pepe/admin/.htaccess</span><br /> <span class="kw1">RewriteEngine</span> <span class="kw2">off</span><br /> <span class="kw1">AuthType</span> Basic<br /> <span class="kw1">AuthUserFile</span> /home/web/pepe/admin/.htpasswd<br /> <span class="kw1">AuthName</span> <span class="st0">"Acceso Administrador"</span><br /> <span class="kw1">Require</span> valid-<span class="kw1">user</span>
  </div>
</div>

Cojonudo, pero sigue haciendo la redirección. <u>Primera comida de cabeza importante</u>: comento todas las reglas de reescritura y sigue redirigiendo ¿? resulta que **Firefox cachea las redirecciones** (al menos las 301), así que ya puedes darle a F5 y estar correctas las reglas, que no te enterarás si no borras la caché del navegador, eso o utilizar Explorer (no lo he probado en el resto).

Descartado el navegador, ésto sigue sin rular. Utilizando el imprescindible [HttpFox](https://addons.mozilla.org/es-ES/firefox/addon/6647/) y Google descubro que la autenticación básica de Apache que queremos usar manda una cabecera **401 Unauthorized**, que el navegador recibe y es cuando muestra el cuadro de usuario/contraseña. <u>Segunda comida de cabeza importante</u>: el servidor está buscando un mensaje de error personalizado para el 401 (en una directiva [ErrorDocument](http://httpd.apache.org/docs/2.0/mod/core.html#errordocument)), que no encuentra y por tanto lanza, adicionalmente, un 404. Y resulta que, no me preguntes por qué, este último error pasa por la reescritura general y es lo que está provocando la redirección. Acojonante. La solución es definir dicho ErrorDocument en nuestro htaccess:

<div class="codecolorer-container apache twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="apache codecolorer">
    <span class="co1"># colocado en /home/web/pepe/.htaccess</span><br /> <span class="kw1">Options</span> +<span class="kw2">FollowSymlinks</span><br /> <span class="kw1">RewriteEngine</span> <span class="kw2">on</span><br /> <span class="kw1">RewriteCond</span> %{REQUEST_URI} !^/admin/?<br /> <span class="kw1">RewriteRule</span> ^(.*)$ http://www.paco.com [R=<span class="nu0">301</span>,L]<br /> <span class="kw1">ErrorDocument</span> <span class="nu0">401</span> <span class="st0">"Acceso restringido"</span>
  </div>
</div>

¡Aparece el cuadro para meter usuario/contraseña! joder, ha costado.