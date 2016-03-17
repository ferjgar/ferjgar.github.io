---
id: 674
title: Scroll infinito con jQuery
date: 2010-04-12T20:15:36+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=674
permalink: /desarrollo/scroll-infinito-con-jquery
categories:
  - Desarrollo
tags:
  - ajax
  - jquery
  - tumblr
---
También conocido como _endless scrolling_, _endless pageless_, _paginación sin páginas_, etc&#8230; es un **patrón de interfaz de usuario** del que se viene hablando desde hace unos años, aunque es últimamente cuando parece que lo veo implementado en cada vez más sitios.

El ejemplo por antonomasia es por supuesto el de Google Reader, pero hay muchos más: Facebook (fijaros que lo hace una vez cuando vas a mitad de página), Digg, Bing, Vimeo, Dropular&#8230;.

Básicamente consiste en cargar más contenido dinámicamente conforme te acercas al final de la página, de forma que la navegación por el mismo no queda interrumpida en ningún momento. Viene a ser un **sustitutivo de la paginación tradicional**.

Luego comentaré los pros y contras que pienso tiene esta técnica. Antes contar cómo lo he implementado en mi tumblr, [micro Usuario de Internet](http://micro.usuariodeinternet.es/), algo que llevaba bastante tiempo queriendo hacer y que sin duda opino le va como anillo al dedo.

<p style="text-align:center;">
  <img src="/img/post/scroll_infinito.png" alt="Scroll infinito en micro.usuariodeinternet.es" />
</p>

Aunque en principio tenía intención de remangarme, encontré un plugin, <a href="http://plugins.jquery.com/project/de-pagify" target="_blank"><strong>de-pagify</strong></a>, que lo implementa de forma muy flexible y aprovechando parte de la _magia_ de jQuery. Utilizar un framework de javascript simplifica considerablemente la codificación del método, que de otra forma sería bastante más laboriosa, sobre todo el paso de procesar el contenido para pintarlo en pantalla.

En la página del plugin viene todo explicado muy claramente, sólo destacar dos cosas:

<ul style="margin-left:30px;">
  <li>
    Hay 4 formas de lanzar el evento para traerse más contenido. Se configura con el párametro <strong>trigger</strong>, y puede ser cuando se llegue a un % de altura de la página, a una altura determinada (pixels), cuando se vea un determinado elemento de la página (mi elección) o incluso dependiendo de la salida de una función propia. La flexibilidad es máxima.
  </li>
  <li>
    Como he comentado, utilizar jQuery ahorra mucho código, y una de las perlas que más me ha gustado es la siguiente línea: <div class="codecolorer-container javascript twitlight" style="overflow:auto;white-space:nowrap;">
      <div class="javascript codecolorer">
        <span class="co1">// Format url as "?page=1 div#wrapper div.post"</span><br /> <span class="kw2">var</span> url <span class="sy0">=</span> <span class="br0">&#91;</span>next.<span class="me1">attr</span><span class="br0">&#40;</span><span class="st0">'href'</span><span class="br0">&#41;</span><span class="sy0">,</span> options.<span class="me1">container</span><span class="sy0">,</span> options.<span class="me1">filter</span><span class="br0">&#93;</span>.<span class="me1">join</span><span class="br0">&#40;</span><span class="st0">' '</span><span class="br0">&#41;</span><span class="sy0">;</span>
      </div>
    </div>
    
    <p>
      El método de ajax <a href="http://api.jquery.com/load/" target="_blank">load</a>, que es con el que nos vamos a traer el contenido de la <em>siguiente página</em> para pintarlo dinámicamente, permite especificar la URL con selectores separados por espacios, de manera que podemos controlar qué elementos, qué HTML al fin y al cabo, queremos que se cargue en la capa que eligamos. Ésto nos ahorra de una tacada tener que hacer alguna modificación en el código de la aplicación (se van a ir pidiendo por ajax sucesivas páginas como si la navegación fuera la clásica) y tener que procesar el HTML que recibimos (se pinta tal cual porque ya viene filtrado con el contenido, lo único que he tenido que modificar de la página es un poco la maquetación).
    </p>
  </li>
</ul>

En definitiva, y en mi opinión:

**PROS**

<ul style="margin-left:30px;">
  <li>
    <em>Experiencia de usuario</em>: no tengo la menor duda de que, para cierto tipo de webs y, sobre todo, de contenido, el eliminar la paginación supone una mejora muy significativa en la forma de navegar por el sitio, comportándose de la forma natural en la que uno esperaría moverse por él.
  </li>
  <li>
    <em>Consumo</em>: cuando desaparece el punto final (pie de página y paginación) pasa a ser un comportamiento natural el hacer scroll indefinidamente y por tanto seguir consumiendo el contenido de manera <em>indefinida</em>.
  </li>
</ul>

**CONTRAS**

<ul style="margin-left:30px;">
  <li>
    <em>Experiencia de usuario</em>: y no es una contradicción, la <em>nueva</em> forma de navegación puede confundir a muchos usuarios menos duchos en esto de Internet, acostumbrados a los puntos de ruptura (paginación), a saber por qué página del libro van y a una estructura de web más convencional.
  </li>
  <li>
    <em>Implementación</em>: no es tema trivial, ya no técnicamente, sino desde el punto de vista de la usabilidad. Por ejemplo está muy unido al dispositivo utilizado: con la rueda del ratón todo es maravilloso, con el teclado o arrastrando la barra de scroll ya pueden darse saltos incómodos. La norma aquí es que sea prácticamente imperceptible para el usuario lo que se está cociendo de fondo (aquí tengo que mejorar mi implementación).
  </li>
  <li>
    <em>Monetización</em>: en sitios que se ganan las habichuelas con la publicidad puede suponer un problema la ubicación de los bloques de anuncios. Un esquema típico de jumbobanner arriba, roba a la derecha y Adsense bajo el contenido queda bastante desvirtuado con esta navegación. Lo mismo con páginas vistas (solucionable con una buena semilla).
  </li>
</ul>