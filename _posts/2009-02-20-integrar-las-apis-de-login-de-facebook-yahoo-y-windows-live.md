---
id: 414
title: Integrar las APIs de login de Facebook, Yahoo y Windows Live
date: 2009-02-20T10:37:55+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=414
permalink: /desarrollo/integrar-las-apis-de-login-de-facebook-yahoo-y-windows-live
categories:
  - Desarrollo
tags:
  - api
  - facebook
  - windows live
  - yahoo
  - test
---
<p style="text-align: center;">
  <img height="150" width="640" border="0" alt="El bonito single sign-on" src="/img/post/singlesignon.jpg" title="El bonito single sign-on" />
</p>

La filosofía del **single sign-on** ha terminado imponiéndose por pura lógica de saturamiento 2.0, con los grandes jugadores vendiendo sus nuevas propuestas (OpenID lo intentó y no lo consiguió&#8230;) y los usuarios cansados de procesos de registro y contraseñas varias. Darles a éstos la oportunidad de usar sus credenciales de alguno de los servicios top para utilizar tu sitio debería ser ya a estas alturas planteado como una funcionalidad primaria de cualquier proyecto web.

Lo que viene a continuación es una guía para implementar en tu web la funcionalidad de &#8220;login externo&#8221; usando las APIs de tres de los grandes: **Facebook**, **Yahoo** y **Windows Live** (Google y OpenID vendrán en otro post). El proceso es similar en todos los casos, y el objetivo es acabar teniendo para utilizar en nuestro código el id único externo (la variable _$id_unico_ en los ejemplos) que nos sirva para identificar y validar al usuario en nuestro sistema local.

<!--more-->

## Facebook

La integración más sencilla de todas ¡5 líneas de código!

La [documentación para desarrolladores de Facebook](http://developers.facebook.com/) es de las mejores, con muchos ejemplos prácticos y una comunidad muy activa. Vamos a hacer **la implementación más sencilla**, sin meternos en [Facebook Connect](http://developers.facebook.com/connect.php), que será chicha para otro post. Los pasos serían los siguientes:

<ol style="margin-left:30px;">
  <li>
    Logueado en tu cuenta de Facebook debes añadirte la <a href="http://www.facebook.com/developers/">aplicación para desarrolladores</a>.
  </li>
  <li>
    Creamos una nueva aplicación, y rellenamos lo básico para que funcione (el resto es para configuraciones más avanzadas) <p style="text-align: center;margin-top:10px;">
      <img src="/img/post/apilog_facebook_campos.png" alt="Campos mínimos para rellenar en la aplicación de Facebook" title="Campos mínimos para rellenar en la aplicación de Facebook" width="701" height="244" />
    </p>
  </li>

  <li>
    Nos bajamos la <a href="http://svn.facebook.com/svnroot/platform/clients/packages/facebook-platform.tar.gz">librería cliente de PHP</a>.
  </li>
  <li>
    ¡Y a picar!
  </li>
</ol>

Resumiendo, tenemos una api key, otra key privada, hemos especificado una URL propia de retorno de Facebook, y tenemos su clase de PHP (nos sobraría con los ficheros _facebook.php_ y _facebookapi\_php5\_restlib.php_). Pues el script para loguearse con Facebook sería tan sencillo como esto:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="kw2"><?php</span><br /> <br /> &nbsp; &nbsp; <span class="co1">// cargamos la clase que nos proporcionan</span><br /> &nbsp; &nbsp; <span class="kw1">require_once</span><span class="br0">&#40;</span><span class="st_h">'apis_externas/facebook/class_facebook.php'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="co1">// datos de la aplicación que se nos facilitan cuando la registramos en Facebook </span><br /> &nbsp; &nbsp; <span class="re0">$appapikey</span> <span class="sy0">=</span> <span class="st_h">'000000000000'</span><span class="sy0">;</span><br /> &nbsp; &nbsp; <span class="re0">$appsecret</span> <span class="sy0">=</span> <span class="st_h">'111111111111'</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="co1">// inicializamos el objeto de la clase</span><br /> &nbsp; &nbsp; <span class="re0">$facebook</span> <span class="sy0">=</span> <span class="kw2">new</span> Facebook<span class="br0">&#40;</span><span class="re0">$appapikey</span><span class="sy0">,</span><span class="re0">$appsecret</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="co1">// si el usuario no está logueado en Facebook le redirigirá allí</span><br /> &nbsp; &nbsp; <span class="re0">$id_unico</span> <span class="sy0">=</span> <span class="re0">$facebook</span><span class="sy0">-></span><span class="me1">require_login</span><span class="br0">&#40;</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="kw1">if</span><span class="br0">&#40;</span><a href="http://www.php.net/empty"><span class="kw3">empty</span></a><span class="br0">&#40;</span><span class="re0">$id_unico</span><span class="br0">&#41;</span><span class="br0">&#41;</span><br /> &nbsp; &nbsp; <span class="br0">&#123;</span><br /> &nbsp; &nbsp; &nbsp; &nbsp; <span class="co1">// si a estas alturas no tenemos el id único algo ha salido mal</span><br /> &nbsp; &nbsp; &nbsp; &nbsp; <span class="re0">$error_api</span> <span class="sy0">=</span> <span class="kw4">true</span><span class="sy0">;</span><br /> &nbsp; &nbsp; <span class="br0">&#125;</span><br /> <br /> <span class="sy1">?></span>
  </div>
</div>

Hay varias formas de hacer esto en Facebook, y no digo que esta sea la más correcta, pero seguro que la más sencilla. La importante es la línea 14, en la que si el usuario está logueado nos devolverá su id único, y sino le enviará a la página de login de Facebook.

## Yahoo

Otra API con integración _no traumática_ gracias a la tecnología [BBAuth de Yahoo](https://developer.yahoo.com/auth/). Aquí también se pueden elegir varias implementaciones (OAuth, OpenID), pero de nuevo vamos a optar por la más sencilla y rápida de desarrollar. Los pasos son los siguientes:

<ol style="margin-left:30px;">
  <li>
    Vamos a la página de <a href="https://developer.yahoo.com/dashboard/">alta de aplicaciones</a> (se necesita usuario de Yahoo).
  </li>
  <li>
    Creamos una nueva <em>Browser-Based Authentication Protected Application</em> <p style="text-align: center;margin-top:10px;">
      <img src="/img/post/apilog_yahoo_campos.gif" alt="Campos mínimos para rellenar en la aplicación de Yahoo" title="Campos mínimos para rellenar en la aplicación de Yahoo" width="665" height="586" />
    </p>
  </li>

  <li>
    Nos pedirán confirmar el dominio subiendo un fichero determinado a nuestra web.
  </li>
  <li>
    Nos bajamos la <a href="https://developer.yahoo.com/auth/quickstart/bbauth_quickstart.zip">librería cliente de PHP</a>.
  </li>
  <li>
    ¡Y a picar!
  </li>
</ol>

Resumiendo de nuevo, tenemos la aplicación creada, apuntadas las dos keys que necesitamos y la clase para comunicarnos con Yahoo (usaremos el fichero _ybrowserauth.class.php4_ o _ybrowserauth.class.php5_ dependiendo de nuestra versión de PHP). El código final quedará así:

[cc lang=&#8221;php&#8221;]

<?php

	// datos de la aplicación que se nos facilitan cuando la registramos en Yahoo
	define('APPID','000000000000');
	define('SECRET','111111111111');
</p>
