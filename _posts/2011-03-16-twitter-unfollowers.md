---
id: 831
title: Script Caza Unfollowers de Twitter
date: 2011-03-16T11:00:30+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=831
permalink: /desarrollo/twitter-unfollowers
categories:
  - Desarrollo
tags:
  - php
  - twitter
---
Las reacciones ante un unfollow en Twitter suelen ser diversas, desde la acción recíproca inmediata (cosa que no logro entender ¿has dejado de ver el telediario porque el presentador no se dirija a ti en persona? pues eso&#8230;) hasta la más absoluta indeferencia. A mi más bien me mueve la curiosidad, saber si ha sido la posible reacción ante un tuit concreto, el perfil de la persona que deja de seguirme, etc&#8230;

Aquí os traigo un pequeño script que he hecho para enterarme de esto. Sé que hay por ahi muchos servicios que hacen lo mismo, los he probado y todos me han parecido una chusta, publicidad, desfase en la notificación y en general nada que cumpla bien algo tan simple como esto. Por eso he acabado tirando unas líneas de código para tenerlo en mi propio servidor y hacer exáctamente lo que espero, que es muy sencillo: **recibir un email cada vez que alguien deje de seguirme en Twitter**. A continuación explico algunos detalles de esta mini aplicación que podéis descargar desde [github](https://github.com/ferjgar/twitter-unfollowers).

<p style="text-align: center;">
  <img src="http://www.usuariodeinternet.es/img/post/twitter-unfollowers.jpg" alt="Esos que te hacen unfollow en Twitter..." />
</p>

<!--more-->


  
Lo primero aclarar que obviamente no es una aplicación de uso general, por las siguientes peculiaridades:

<ul style="margin-left: 30px;">
  <li>
    Aunque fácilmente modificable, hace únicamente lo que yo necesito, explicado al principio
  </li>
  <li>
    Está limitada a 5000 followers (por defecto el límite de la API de Twitter si no se utiliza paginación), cuando sobrepase esa cifra ya lo modificaré ;)
  </li>
  <li>
    Utiliza un fichero para almacenar los followers y arrays para comparar, lo cual con un número elevado de ellos no sé cómo rendirá
  </li>
</ul>

Al turronaco. El único requerimiento es la extensión **curl** de PHP, que se utiliza para llamar a las APIs de Twitter. La gestión de errores es como un martillo, si no hay curl o alguna API devuelve un error el script termina, no necesito nada más sofisticado.

La única personalización necesaria está en el fichero <span class="codigo">twitter_unfollowers.php</span>, para los campos del email que recibiremos:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="co1">// fichero donde se guardan los followers para posteriormente compararlos con los actuales</span><br /> <a href="http://www.php.net/define"><span class="kw3">define</span></a><span class="br0">&#40;</span><span class="st_h">'FIC_GUARDADO'</span><span class="sy0">,</span> <span class="st_h">'twitter_followers_{USUARIO}.db'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <span class="co1">// poner a 0 si no quieres recibir un email con la lista de unfollowers</span><br /> <a href="http://www.php.net/define"><span class="kw3">define</span></a><span class="br0">&#40;</span><span class="st_h">'ENVIAR_EMAIL'</span><span class="sy0">,</span> <span class="st_h">'1'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <a href="http://www.php.net/define"><span class="kw3">define</span></a><span class="br0">&#40;</span><span class="st_h">'EMAIL_DIRECCION'</span><span class="sy0">,</span> <span class="st_h">'xxxx@yyyy.com'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <a href="http://www.php.net/define"><span class="kw3">define</span></a><span class="br0">&#40;</span><span class="st_h">'EMAIL_ASUNTO'</span><span class="sy0">,</span> <span class="st_h">'[TWITTER] Te ha(n) desfollogüeado {NUM} usuario(s)'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <span class="co1">// dirección válida en el servidor donde se ejecuta el script para que el email no se vaya al spam</span><br /> <a href="http://www.php.net/define"><span class="kw3">define</span></a><span class="br0">&#40;</span><span class="st_h">'EMAIL_REMITENTE'</span><span class="sy0">,</span> <span class="st_h">'iiii@jjjj.com'</span><span class="br0">&#41;</span><span class="sy0">;</span>
  </div>
</div>

Podemos utilizar esta clase en un simple script que se pondría en el [cron](http://es.wikipedia.org/wiki/Cron_%28Unix%29), como por ejemplo:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="kw2"><?php</span><br /> <br /> &nbsp; &nbsp; <span class="kw1">require</span><span class="br0">&#40;</span><span class="st_h">'twitter_unfollowers.php'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="re0">$tuiter</span> <span class="sy0">=</span> <span class="kw2">new</span> Twitter_unfollowers<span class="br0">&#40;</span><span class="st_h">'<id_usuario_twitter>'</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="re0">$tuiter</span><span class="sy0">-></span><span class="me1">check_unfollow</span><span class="br0">&#40;</span><span class="br0">&#41;</span><span class="sy0">;</span><br /> <br /> &nbsp; &nbsp; <span class="kw1">echo</span> <span class="st_h">'fin'</span><span class="sy0">;</span><br /> &nbsp; <br /> <span class="sy1">?></span>
  </div>
</div>

<div id="entry_download">
  <p>
    <a href="https://github.com/ferjgar/twitter-unfollowers">descargar en <strong>github</strong></a><br /> Twitter Unfollowers 1.2
  </p>
</div>

<div id="entry_footnotes">
  <p>
    Changelog
  </p>
  
  <p>
    v1.2 &#8211; Arreglados problemas de codificación y control de errores de la API<br /> v1.1 &#8211; Eliminada la necesidad de autenticarse con OAuth para utilizar las APIs<br /> v1.0 &#8211; Desarrollo inicial
  </p>
</div>