---
id: 973
title: Utilizar GitHub for Windows con Bitbucket
date: 2012-10-22T12:00:05+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=973
permalink: /desarrollo/utilizar-github-for-windows-con-bitbucket
categories:
  - Desarrollo
tags:
  - git
---
O GitHub for Mac, aunque aquí haya más alternativas como <a href="http://www.git-tower.com/" target="_blank">Tower</a> (brutal) o <a href="http://www.sourcetreeapp.com/" target="_blank">SourceTree</a>, pero el caso es que la GUI de GitHub no limita su uso a sus repositorios.

Aquí daré por sentado lo siguiente:

  * **Tenéis Windows**: es sangrante la falta de un cliente de git de referencia, y mira que he sido años usuario de TortoiseSVN, pero <a href="http://code.google.com/p/tortoisegit/" target="_blank">TortoiseGit</a>&#8230; pse&#8230;
  * **Tenéis cuenta en GitHub**: atento, **no es obligatorio**, pero te va a facilitar el paso de la creación de las claves SSH y encontrar trabajo.
  * **Tenéis cuenta en Bitbucket**: repositorios privados, no digo más.

Bien, lo primero será descargar e instalar <a href="http://windows.github.com/" target="_blank">GitHub for Windows</a>. Se han currado la interfaz Metro, eh?

Aunque como digo se puede utilizar sin GitHub, vamos a loguearnos en nuestra cuenta, porque esto automáticamente nos creará la clave SSH que necesitaremos en Bitbucket. Para confirmar que así ha sido, podéis ir a vuestro perfil y comprobar que se ha añadido una nueva en el <a href="https://github.com/settings/ssh" target="_blank">listado de SSH keys</a>.

Ahora vamos a copiar la **clave pública** generada, que se encuentra en el directorio _.ssh_ de vuestro usuario en Windows (_C:\Users\<tu usuario>\.ssh_), en el fichero **_github_rsa.pub_**.

Con ese chorizín nos vamos a nuestra cuenta en Bitbucket y lo añadimos como nueva SSH key (https://bitbucket.org/account/user/<tu usuario>/ssh-keys/).

Suponiendo que ya tenéis un repositorio creado en Bitbucket, también en posible que ya lo tengáis clonado en vuestro PC. Si no, lo vamos a hacer con otra bonita herramienta que instala el programa, el **Git Shell**. Lo abrimos, nos vamos al directorio de nuestra elección y le cascamos un entrañable clone:

<img title="gitclone" src="http://www.usuariodeinternet.es/img/post/gitclone1.png" width="535" height="170" />

Pero poniendo la dirección de vuestro repositorio, que hay que explicarlo todo!

Ya sólo queda arrastrar directamente esta nueva carpeta al programa, et voilà! a partir de ahora podemos gestionar nuestro prometedor repositorio desde esta más que correcta herramienta, veremos cómo evoluciona.