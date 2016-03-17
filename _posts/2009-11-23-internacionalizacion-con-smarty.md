---
id: 532
title: Internacionalización con Smarty
date: 2009-11-23T09:16:06+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=532
permalink: /desarrollo/internacionalizacion-con-smarty
categories:
  - Desarrollo
tags:
  - php
  - smarty
---
<p style="text-align: center;">
  <img title="Internacionalización con Smarty" src="/img/post/smarty_i18n.png" border="0" alt="Internacionalización con Smarty" width="640" height="97" />
</p>

El temita de la internacionalización (_i18n_ para los amigos) en una aplicación web puede dar para largo y tendido, yo voy a hablar aquí concretamente de la **forma de guardar y utilizar las cadenas de texto** del site en varios idiomas utilizando el framework de templates <a href="http://www.smarty.net" target="_blank">Smarty</a>.

Hay muchas formas de hacerlo, se pueden encontrar varias alternativas en este post de <a href="http://www.smarty.net/forums/viewtopic.php?t=84&#038;postdays=0&#038;postorder=asc&#038;start=0" target="_blank">best way to build a multi-language site with smarty</a>, que empezó en el ¡2003! (el frenético ritmo que lleva la tecnología hace que no me crea nada que no sea de ayer&#8230;). Todas tienen sus ventajas e inconvenientes, y dado que no hay nada en el core de Smarty para ésto ni una solución popularmente aceptada como la _estándar_, cada uno debe analizar lo que necesita para su proyecto y tener unas preferencias subjetivas, que en mi caso son:

<ul style="margin-left:30px;">
  <li>
    <strong>Que no implique PHP</strong>: obviamente hay opciones mucho más sofisticadas, eficientes, etc&#8230; para solucionar el tema del i18n con programación (por ejemplo <a href="http://sourceforge.net/projects/smarty-gettext/" target="_blank">smarty-gettext</a>), pero precisamente el uso de Smarty es para separar la lógica de la aplicación de la de presentación, y dado que considero que ésto es problema de front-end puro, yo quiero resolverlo únicamente con Smarty.
  </li>
  <li>
    <strong>Que sea sencillo y eficiente</strong>: con el tiempo me estoy conviertiendo en un talibán del código, en el sentido bueno (creo) de intentar que las cosas se hagan de la forma más clara posible (<a href="http://es.wikipedia.org/wiki/Principio_KISS" target="_blank">KISS</a> power!) y que note un pinchazo en el corazón con cada ciclo de reloj que se consume en código prescindible.
  </li>
</ul>

<!--more-->


   
Por ejemplo, hay una solución **muy buena** y que he utilizado en otros proyectos, <a href="http://smarty.incutio.com/?page=SmartyMultilanguageSupport" target="_blank">SmartyML</a>, pero es una clase más en PHP (una capa más para procesar) y viendo tanto código pienso que debe haber una forma mejor de hacerlo.

Pero vamos al turrón. Al final encontré en el foro antes mencionado la solución que me parece más sencilla y adecuada para lo que necesito. Se trata de utilizar <a href="http://smarty.net/manual/es/config.files.php" target="_blank"><strong>archivos de configuración</strong></a> (1ª ventaja: es una funcionalidad core de Smarty, con lo que no hay que añadir más complejidad). En estos ficheros se definen variables globales para los templates y se pueden aplicar de varias formas:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="co1">// desde el PHP</span><br /> <span class="re0">$smarty</span><span class="sy0">-></span><span class="me1">config_load</span><span class="br0">&#40;</span><span class="st_h">'fichero.conf'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> <span class="co1">// desde el template</span><br /> <span class="br0">&#123;</span>config_load <a href="http://www.php.net/file"><span class="kw3">file</span></a><span class="sy0">=</span><span class="st_h">'fichero.conf'</span><span class="br0">&#125;</span>
  </div>
</div>

Yo prefiero hacerlo desde PHP porque la gestión del idioma de la web es lógica de aplicación y hay que poner cada cosa en su sitio. El directorio donde se almacenan estos ficheros debe ser definido en el código:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="re0">$smarty</span> <span class="sy0">=</span> <span class="kw2">new</span> Smarty<span class="br0">&#40;</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <span class="re0">$smarty</span><span class="sy0">-></span><span class="me1">config_dir</span> &nbsp; <span class="sy0">=</span> <span class="st_h">'/path/al/directorio/'</span><span class="sy0">;</span>
  </div>
</div>

Crearemos un archivo por idioma, en los que tendremos todas las cadenas de texto que vamos a utilizar traducidas, por ejemplo:

<div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="smarty codecolorer">
    # /path/al/directorio/es.conf (español)<br /> saludo = hola!<br /> enviar = Enviar<br /> cancelar = Cancelar
  </div>
</div>

<div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="smarty codecolorer">
    # /path/al/directorio/en.conf (inglés)<br /> saludo = hi!<br /> enviar = Send<br /> cancelar = Cancel
  </div>
</div>

Utilizar estas variables en los templates es tan sencillo como usar la sintaxis **{#variable#}**, por ejemplo:

<div class="codecolorer-container html4strict twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="html4strict codecolorer">
    <span class="sc2"><<a href="http://december.com/html/4/element/strong.html"><span class="kw2">strong</span></a>></span>{#saludo#}<span class="sc2"><<span class="sy0">/</span><a href="http://december.com/html/4/element/strong.html"><span class="kw2">strong</span></a>></span><br /> <span class="sc2"><<a href="http://december.com/html/4/element/input.html"><span class="kw2">input</span></a> <span class="kw3">type</span><span class="sy0">=</span><span class="st0">"button"</span> <span class="kw3">name</span><span class="sy0">=</span><span class="st0">"enviar"</span> <span class="kw3">value</span><span class="sy0">=</span><span class="st0">"{#enviar#}"</span> <span class="sy0">/</span>></span><br /> <span class="sc2"><<a href="http://december.com/html/4/element/input.html"><span class="kw2">input</span></a> <span class="kw3">type</span><span class="sy0">=</span><span class="st0">"button"</span> <span class="kw3">name</span><span class="sy0">=</span><span class="st0">"cancelar"</span> <span class="kw3">value</span><span class="sy0">=</span><span class="st0">"{#cancelar#}"</span> <span class="sy0">/</span>></span>
  </div>
</div>

¡Y ya está! desde el PHP se puede controlar qué archivo de configuración de idioma cargar y de esta manera tener montada nuestra web multilenguaje. Unos últimos apuntes:

<ul style="margin-left:30px;">
  <li>
    Las cadenas también pueden llevar <strong>texto variable</strong>, como por ejemplo un saludo del tipo <em>Hola Fernando, bienvenido!</em> Ésto se puede solucionar de dos formas: <div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="smarty codecolorer">
        # forma CUTRE: en el tpl<br /> <span class="sc2"><strong></span><span class="br0">&#123;</span>#saludo1#<span class="br0">&#125;</span><span class="br0">&#123;</span><span class="re0">$nombre_usuario</span><span class="br0">&#125;</span><span class="br0">&#123;</span>#saludo2#<span class="br0">&#125;</span><span class="sc2"></strong></span><br /> <br /> # en el archivo de configuración de idioma<br /> saludo1 = Hola<br /> saludo2 = bienvenido!
      </div>
    </div>
    
    <div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="smarty codecolorer">
        # forma CORRECTA: en el tpl<br /> <span class="sc2"><strong></span><span class="br0">&#123;</span><a href="http://smarty.php.net/eval"><span class="kw3">eval</span></a> var<span class="sy0">=</span>#saludo#<span class="br0">&#125;</span><span class="sc2"></strong></span><br /> <br /> # en el archivo de configuración de idioma<br /> saludo = Hola <span class="br0">&#123;</span><span class="re0">$nombre_usuario</span><span class="br0">&#125;</span>, bienvenido!
      </div>
    </div>
  </li>
  
  <li>
    En lo que entiendo es una <strong>optimizacion</strong> (supongo que a nivel interno se controlará), se pueden utilizar <strong>secciones</strong> (referenciadas así <em>[seccion]</em>) en el archivo de configuración, de manera que si se especifica una en el <em>config_load</em> sólo esas variables se <em>cargarán</em> (la que estén fuera de una sección estarán siempre disponibles). Ésto nos puede servir para organizar las cadenas de texto por página y suponer que Smarty lo manejará mejor que el chorro completo de variables. Quedaría así: <div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="smarty codecolorer">
        # cadenas globales<br /> saludo = Hola!<br /> enviar = Enviar<br /> <br /> # página de login<br /> [login]<br /> titulo = Introduce tu usuario y contraseña
      </div>
    </div>
    
    <p>
      Y desde el PHP:
    </p>
    
    <div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="php codecolorer">
        <span class="re0">$smarty</span><span class="sy0">-></span><span class="me1">config_load</span><span class="br0">&#40;</span><span class="st_h">'es.conf'</span><span class="sy0">,</span><span class="st_h">'login'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <span class="re0">$smarty</span><span class="sy0">-></span><span class="me1">display</span><span class="br0">&#40;</span><span class="st_h">'login.tpl'</span><span class="br0">&#41;</span><span class="sy0">;</span>
      </div>
    </div>
  </li>
  
  <li>
    Una desventaja es que no maneja de manera nativa los <strong>plurales</strong> como otras soluciones, de forma que hay que controlarlo a manubrio, por ejemplo: <div class="codecolorer-container smarty twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="smarty codecolorer">
        # en el tpl<br /> <span class="br0">&#123;</span><a href="http://smarty.php.net/eval"><span class="kw3">eval</span></a> var<span class="sy0">=</span>#subida_fotos#<span class="br0">&#125;</span><span class="br0">&#123;</span><a href="http://smarty.php.net/if"><span class="kw1">if</span></a> <span class="re0">$num_fotos</span> <span class="sy0">></span> <span class="nu0">1</span><span class="br0">&#125;</span>s<span class="br0">&#123;</span><span class="sy0">/</span><a href="http://smarty.php.net/if"><span class="kw1">if</span></a><span class="br0">&#125;</span><br /> <br /> # en el archivo de configuración de idioma<br /> subida_fotos = Has subido <span class="br0">&#123;</span><span class="re0">$num_fotos</span><span class="br0">&#125;</span> foto
      </div>
    </div>
  </li>
</ul>