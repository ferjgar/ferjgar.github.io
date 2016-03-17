---
id: 8
title: Nuevas APIs de Google
date: 2008-02-29T15:15:53+00:00
author: fer
layout: post
guid: http://www.fernandogarciatorres.es/personal/nuevas-apis-de-google
permalink: /desarrollo/nuevas-apis-de-google
categories:
  - Desarrollo
tags:
  - api
  - google
  - mapas
---
Google es La Luz, el Faro de Internet que guía a necios e ignorantes hasta la Revelación. Practican su máxima de &#8220;_Don&#8217;t be evil_&#8221; (siempre que nos me toques las cuentas, gañán) y suelen compartir su Infinita Sabiduría con la plebe en forma de APIs que degustamos con placer. Su última ofrenda es doble, por un lado una forma de **estatificar sus gloriosos mapas** y por otro el acceso global a las **relaciones entre las personas** en Internet. Gracias, oh Google.

<!--more-->

## **<u>Mapas Estáticos con Google Maps</u>**

Esta nueva API de Google viene a ser una &#8220;involución&#8221; lógica de la archifamosa <a href="http://code.google.com/apis/maps/" title="Todos los detalles sobre Google Maps API" target="_blank">Google Maps API</a>. Ya todos sabemos el partido que se le pueden sacar a esos mapas, pero muchas veces se usan para **fines muy concretos y poco sofisticados**. En esos casos sobra toda la interactividad que nos ofrece la API, y es precisamento éso lo que han venido a cubrir los nuevos mapas estáticos. Su uso es insultántemente sencillo, y se reduce a utilizar la etiqueta <img> de HTML con un src determinado, limpio y fácil:

<p style="text-align: center; font-size: 12px">
  <<span class="start-tag">img</span><span class="attribute-name"> src</span>=<span class="attribute-value">&#8220;http://maps.google.com/staticmap?center=<font color="#ff0000"><coor1></font>,<font color="#ff0000"><coor2></font>&zoom=<font color="#ff0000"><nivel de zoom></font>&size=<font color="#ff0000"><ancho></font>x<font color="#ff0000"><alto></font>&key=<font color="#ff0000"><API key></font>&#8221; </span><span class="error"><span class="attribute-name">/</span></span>>
</p>

Esta llamada te devuelve una imagen de los servidores de Google con un bonito mapa centrado en las coordenadas dadas. Las **diferencias en cuanto a rendimiento** son muy claras, pongo a continuación dos capturas del análisis de la carga de dos páginas hecha con la extensión <a href="http://www.getfirebug.com/" title="Extensión Firebug para el navegador Firefox" target="_blank">Firebug</a>, ambas mostrando exáctamente el mismo punto del mapa:

<p align="center">
  <span style="font-size: 12px">Google Maps API &#8211; ejem: <a href="http://www.desfasetotal.com/gmaps.html" title="Ejemplo de utilización de Google Maps API" target="_blank">http://www.desfasetotal.com/gmaps.html</a></span><br /> <img src="/img/post/api.gif" alt="Tiempos y objetos con google maps API" height="496" width="571" />
</p>

<p align="center">
  <span style="font-size: 12px">Google Maps Estáticos API &#8211; ejem: <a href="http://www.desfasetotal.com/gmaps_static.html" title="Ejemplo de utilización de Google Maps API estáticos" target="_blank">http://www.desfasetotal.com/gmaps_static.html</a></span><br /> <img src="/img/post/api_estat.gif" alt="Tiempos y objetos con google maps API estática" height="156" width="570" />
</p>

<p align="left">
  Las cifras cantan:
</p>

<table style="border: 1px solid #000000; padding: 15px; margin-bottom: 10px; width: 500px" border="0">
  <tr>
    <td>
      &nbsp;
    </td>
    
    <td align="right">
      <strong>objetos</strong>
    </td>
    
    <td align="right">
      <strong>transferencia</strong>
    </td>
    
    <td align="right">
      <strong>latencia</strong>
    </td>
  </tr>
  
  <tr>
    <td align="right">
      <strong>Google Maps</strong>
    </td>
    
    <td align="right">
      22
    </td>
    
    <td align="right">
      294 KB
    </td>
    
    <td align="right">
      4.24 seg
    </td>
  </tr>
  
  <tr>
    <td align="right">
      <strong>Google Maps Estáticos</strong>
    </td>
    
    <td align="right">
      2
    </td>
    
    <td align="right">
      61 KB
    </td>
    
    <td align="right">
      0.7 seg
    </td>
  </tr>
</table>

Quedan muy a las claras las **ventajas** de esta nueva API. Cuando el uso de los mapas se reduce a colocar un marcador en un sitio determinado, como en una web de bares para situar los locales (se pueden crear pines en las imágenes generadas añadiendo otro campo con las coordenadas en la llamada), es de uso obligatorio este nuevo método, primero por las **diferencias en tiempos/peso de carga**, y segundo por la **sencillez de uso** de la nueva llamada. Otra ventaja que puede resultar útil es la posibilidad de **guardar la imagen** del mapa, cosa que con la API normal de Google Maps no se puede hacer de forma directa.

Supongo que las dos APIs van a convivir perfectamente en muchas webs, por ejemplo un perfil de usuario que permita geolocalización utilizará la API dinámica cuando lo esté editando, y la API estática en el front para mostrar el mapa de donde me encuentro. Un servicio muy útil, sí señor.

Anuncio en español: <a href="http://programa-con-google.blogspot.com/2008/02/mapas-estticos-con-google-maps.html" title="Nueva API de Google para obtener mapas estáticos de Google Maps" target="_blank">Mapas estáticos con Google Maps</a>

Web oficial de la API: <a href="http://code.google.com/apis/maps/documentation/staticmaps/index.html" title="Google Static Maps API" target="_blank">Google Static Maps API</a>

<p align="left">
  &nbsp;
</p>

## <u>**API de Gráfico Social**</u>

<p align="left">
  <img src="/img/post/the-web.png" webdeveloper-inline-style="border: medium none ; background: transparent none repeat scroll 0% 50%; -moz-background-clip: -moz-initial; -moz-background-origin: -moz-initial; -moz-background-inline-policy: -moz-initial;" alt="La nueva Social Graph API de Google" align="left" height="389" width="375" />Sería la traducción literal de esta API &#8220;social&#8221; que cuesta entender. Google se lanza a la <strong>búsqueda de relaciones</strong> en el apogeo de las redes sociales.
</p>

<p align="left">
  Basándose en los estándares <a href="http://gmpg.org/xfn/" title="Estándar Xhtml Friends Network" target="_blank">XFN</a> (Xhtml Friends Network) y <a href="http://www.foaf-project.org/" title="The Friend of a Friend project" target="_blank">FOAF</a> (The Friend of a Friend), de forma simplificada se trata de analizar la <strong>etiqueta rel</strong> (en el caso de XFN) que se puede añadir a los enlaces de una web y los <strong>documentos FOAF</strong> para formar un gráfico social a nivel global que permita, usando la API, establecer relaciones entre las personas a través de su presencia pública en Internet.
</p>

<p align="left">
  En la página oficial hay un video con un ejemplo muy bueno que viene a sugerir la utilidad que puede tener ésto. Pongamos que tengo un blog con una serie de enlaces a páginas de amigos a los que añado la etiqueta <em><strong>rel=&#8221;friend&#8221;</strong></em>. Un día me apunto a <a href="http://twitter.com" title="http://twitter.com" target="_blank">Twitter</a> y me encuentro hablando con la pared porque no tengo añadido a nadie. Si he puesto mi blog en mi perfil público, automáticamente el enlace aparece con la etiqueta <em><strong>rel=&#8221;me&#8221;</strong></em>. Pues bien, Twitter puede desarrollar una aplicación utilizando la API de Google de manera que me pueda sugerir añadir a gente de mi &#8220;red social&#8221; que ya están registrados en el portal. Google sabe por la etiqueta <em>rel=&#8221;me&#8221;</em> que tengo un blog y desde él ve que tengo también una serie de amigos por la etiqueta <em>rel=&#8221;friends&#8221;</em>. Al final aquellos que estén registrados en Twitter y hayan puesto la dirección de su página en su perfil cerrarán el círculo de mi minigrafo social aplicado a Twitter.
</p>

Es lioso y a mi por ahora no se me ocurre una aplicación realmente útil que pueda usar en nuestros proyectos, aparte del hecho de depender de que se adopte algunos de los estándares citados para poder establecer las relaciones, pero estoy seguro que en este panorama de Red Social esta API dará que hablar.

Web oficial de la API: <a href="http://code.google.com/apis/socialgraph/" title="Google Social Graph API" target="_blank">Social Graph API</a>