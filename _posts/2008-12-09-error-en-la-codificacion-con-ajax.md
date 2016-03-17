---
id: 20
title: Error en la codificación con AJAX
date: 2008-12-09T03:43:05+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=20
permalink: /desarrollo/error-en-la-codificacion-con-ajax
categories:
  - Desarrollo
tags:
  - ajax
  - javascript
---
<p style="text-align: center">
  <img title="¿Matrix utiliza UTF-8?" src="/img/post/matrix_code.jpg" border="0" alt="¿Matrix utiliza UTF-8?" width="640" height="150" />
</p>

Pelearse con la codificación de los caracteres en una aplicación web es pan nuestro de cada día. En un desarrollo sencillo uno puede olvidarse de ese detalle y dejar el trabajo de cloacas al navegador y el PHP. Pero en el momento en que entran en juego **javascript y fuentes externas de datos**, es entonces cuando la posibilidades de **cagarla** se multiplican.

Una de las formas más sencillas de prevenir problemas con la codificación es utilizar siempre **UTF-8** para el desarrollo completo de la aplicación. Ésto incluye la base de datos, una línea al principio de todo script:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <a href="http://www.php.net/header"><span class="kw3">header</span></a><span class="br0">&#40;</span><span class="st_h">'Content-type: text/html; charset=utf-8'</span><span class="br0">&#41;</span><span class="sy0">;</span>
  </div>
</div>

También en los HTML:

<div class="codecolorer-container html4strict twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="html4strict codecolorer">
    <span class="sc2"><<a href="http://december.com/html/4/element/meta.html"><span class="kw2">meta</span></a> <span class="kw3">http-equiv</span><span class="sy0">=</span><span class="st0">"Content-Type"</span> <span class="kw3">content</span><span class="sy0">=</span><span class="st0">"text/html; charset=UTF-8"</span> <span class="sy0">/</span>></span>
  </div>
</div>

Y por supuesto, que el fichero esté **físicamente** codificado en UTF-8, cosa que cada uno deberá hacer con el editor de código correspondiente (mi experiencia con [Ultraedit](http://www.ultraedit.com/) en este sentido es inmejorable).

El horror comienza cuando no has hecho los deberes, y a una aplicación sencilla se le quiere empezar a meter AJAX y datos de diversas fuentes. Por defecto tu tinglado estará utilizando seguramente **ISO 8859-1**, la codificación del alfabeto latino, y éso es lo que va a estar esperando el navegador a no ser que le indiques lo contrario&#8230;

<p style="text-align: center">
  <img title="Mala codificación de los caracteres" src="/img/post/char_raros.gif" border="0" alt="Mala codificación de los caracteres" width="374" height="169" />
</p>

Estos problemas de codificación se pueden deber a múltiples razones, sería imposible cubrirlas todas en un post, así que me centraré en las dos con las que he tenido que lidiar estos días:

<ul style="padding-left:30px;">
  <li>
    <strong>API EXTERNA</strong>. Aquí no queda otra, Si la API no ofrece un parámetro para especificar la codificación, va a venir en UTF-8 prácticamente seguro y tocará hacer en el código, por ejemplo en PHP, un <a href="http://es.php.net/utf8-decode" target="_blank">utf8_decode</a> de lo que devuelva.
  </li>
  <li style="margin-top:15px;">
    <strong>AJAX</strong>. La diversión con la codificación de caracteres cuando entra en juego el javascript puede no llegar a tener límite. Si, para más inri, utilizamos AJAX para comunicar con un script pongamos de PHP, entonces tenemos todos los ingredientes para la empanada de caracteres raros. <p style="margin-top:10px;">
      Obviando detalles de bajo nivel como que el objeto XMLHttpRequest que se encarga de esta comunicación utiliza siempre UTF-8, o que dependiendo de si utilizas GET o POST e Internet Explorer o Firefox se usará una codificación u otra, vemos que las combinaciones pueden marear hasta la náusea, así que hay que buscar una solución que funcione independientemente de la codificación origen-destino, el navegador o el protocolo utilizado.
    </p>
    
    <p>
      Tras varios intentos, dí con una combinación que parece comerse cualquier barbaridad que se pueda poner en un formulario (una caja de texto que acepte código de programación, textos chinos o búlgaros&#8230; es un reto). El flujo sería el siguiente:
    </p>
    
    <ol>
      <li>
        Desde el javascript mandamos los datos codificados con la función <a href="http://xkr.us/articles/javascript/encode-compare/"><strong>encodeURIComponent</strong></a> (utilizar otra nos dará problemas con los caracteres <em>&#038;</em> y <em>+</em>), por ejemplo: <div class="codecolorer-container javascript twitlight" style="overflow:auto;white-space:nowrap;">
          <div class="javascript codecolorer">
            ajax.<span class="kw3">open</span><span class="br0">&#40;</span><span class="st0">'get'</span><span class="sy0">,</span><span class="st0">'url_script.php?datos='</span><span class="sy0">+</span>encodeURIComponent<span class="br0">&#40;</span>datos<span class="br0">&#41;</span><span class="sy0">,</span><span class="kw2">true</span><span class="br0">&#41;</span><span class="sy0">;</span>
          </div>
        </div>
      </li>
      
      <li>
        Dependiendo del lenguaje de programación que se utilice en el script que recibe los datos habrá que hacer una decodificación o no de los mismos. PHP automáticamente lo realiza para lo que recibe por GET, como en este ejemplo.
      </li>
      <li>
        Para devolver la respuesta, con PHP utilizamos <a href="http://es.php.net/manual/es/function.rawurlencode.php"><strong>rawurlencode</strong></a> para codificarla (esta función lo realiza de forma más estricta que <a href="http://es.php.net/manual/es/function.urlencode.php">urlencode</a>). Por ejemplo: <div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
          <div class="php codecolorer">
            <span class="kw1">echo</span> <a href="http://www.php.net/rawurlencode"><span class="kw3">rawurlencode</span></a><span class="br0">&#40;</span><span class="re0">$respuesta</span><span class="br0">&#41;</span><span class="sy0">;</span>
          </div>
        </div>
      </li>
      
      <li>
        Finalmente, de vuelta a javascript, decodificamos la respuesta con <a href="http://www.w3schools.com/jsref/jsref_decodeURIComponent.asp"><strong>decodeURIComponent</strong></a>, y ya tenemos una bonita cadena de caracteres lista para utilizar sin problemas de codificación. Por ejemplo: <div class="codecolorer-container javascript twitlight" style="overflow:auto;white-space:nowrap;">
          <div class="javascript codecolorer">
            <span class="kw2">var</span> respuesta <span class="sy0">=</span> ajax.<span class="me1">responseText</span><span class="sy0">;</span><br /> div.<span class="me1">innerHTML</span> <span class="sy0">=</span> decodeURIComponent<span class="br0">&#40;</span>respuesta<span class="br0">&#41;</span><span class="sy0">;</span>
          </div>
        </div>
      </li>
    </ol>
  </li>
</ul>

En definitiva, **hay que utilizar UTF-8**, hay que dejarle al navegador muy claro que lo estamos haciendo, y tenemos que usar una serie de métodos para que en el trasiego de la información entre distintos lenguajes y scripts no se pierda la codificación.