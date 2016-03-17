---
id: 140
title: Plantilla personalizada para las Páginas de WordPress
date: 2008-10-11T20:16:02+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=140
permalink: /desarrollo/plantilla-personalizada-para-las-paginas-de-wordpress
categories:
  - Desarrollo
tags:
  - wordpress
---
Los que hayan utilizado WordPress para crear un blog saben que en él se pueden escribir **Posts** (Entradas) y **Páginas**. Los Posts son el núcleo del blog, y van a tener el diseño del tema que estés utilizando. Las Páginas por su parte son entidades estáticas, o más bien atemporales, que puedes añadir a la estructura de tu blog.

El tema es que si ves un Post y una Página de un blog no se puede diferenciar a simple vista qué es cada cosa. Mi problema era que quería tener Páginas que cuando estuvieran publicadas no mostraran elementos propios de los Posts, como la fecha de publicación, comentarios, tags, categoría&#8230; así como la posibilidad de tunear si fuera necesario un poco la estructura que me impone el tema que utilizo.

Indagando un poco descubrí una <a href="http://codex.wordpress.org/Pages#Page_Templates" target="_blank">funcionalidad que ofrece WordPress para las Páginas</a>, los **Page Templates**. Al final es todo tan sencillo como añadir la siguientes líneas al principio de un fichero php que debes tener en la carpeta del tema que utilices:

<div class="codecolorer-container php twitlight" style="overflow:auto;white-space:nowrap;">
  <div class="php codecolorer">
    <span class="kw2"><?php</span><br /> &nbsp; <span class="coMULTI">/*<br /> &nbsp; Template Name: pagina limpia<br /> &nbsp; */</span><br /> <span class="sy1">?></span>
  </div>
</div>

Lo que yo hice fue coger el fichero _page.php_, que es el que se utiliza por defecto para las Páginas, renombrarlo a _page-limpia.php_, añadirle al principio las líneas arriba mencionadas, y quitar lo que me sobraba (comentarios, fechas&#8230;). Al ir a crear una nueva página, WordPress detectará esta nueva plantilla y aparecerá una nueva opción avanzada en el editor:

<p align="center">
  <img title="Opción en el editor para cambiar la plantilla de la Página" src="/img/post/plantilla_pagina.gif" alt="Opción en el editor para cambiar la plantilla de la Página" width="758" height="260" />
</p>