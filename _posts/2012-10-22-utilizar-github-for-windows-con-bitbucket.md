---
layout: post
tags: git
---
O GitHub for Mac, aunque aquí haya más alternativas como [Tower](http://www.git-tower.com) (brutal) o [SourceTree](http://www.sourcetreeapp.com), pero el caso es que la GUI de GitHub no limita su uso a sus repositorios.

Aquí daré por sentado lo siguiente:

- **Tenéis Windows**: es sangrante la falta de un cliente de git de referencia, y mira que he sido años usuario de TortoiseSVN, pero [TortoiseGit](https://tortoisegit.org)&#8230; pse&#8230;
- **Tenéis cuenta en GitHub**: atento, **no es obligatorio**, pero te va a facilitar el paso de la creación de las claves SSH y encontrar trabajo.
- **Tenéis cuenta en Bitbucket**: repositorios privados, no digo más.

Bien, lo primero será descargar e instalar [GitHub for Windows](http://windows.github.com). Se han currado la interfaz Metro, eh?

Aunque como digo se puede utilizar sin GitHub, vamos a loguearnos en nuestra cuenta, porque esto automáticamente nos creará la clave SSH que necesitaremos en Bitbucket. Para confirmar que así ha sido, podéis ir a vuestro perfil y comprobar que se ha añadido una nueva en el [listado de SSH keys](https://github.com/settings/ssh).

Ahora vamos a copiar la **clave pública** generada, que se encuentra en el directorio `.ssh` de vuestro usuario en Windows (`C:\Users\<tu usuario>\.ssh`), en el fichero `_github_rsa.pub_`.

Con ese chorizín nos vamos a nuestra cuenta en Bitbucket y lo añadimos como nueva SSH key (`https://bitbucket.org/account/user/<tu usuario>/ssh-keys/`).

Suponiendo que ya tenéis un repositorio creado en Bitbucket, también en posible que ya lo tengáis clonado en vuestro PC. Si no, lo vamos a hacer con otra bonita herramienta que instala el programa, el **Git Shell**. Lo abrimos, nos vamos al directorio de nuestra elección y le cascamos un entrañable clone:

![Git clone](/assets/img/2012-10-22-git-clone.png)

Pero poniendo la dirección de vuestro repositorio, que hay que explicarlo todo!

Ya sólo queda arrastrar directamente esta nueva carpeta al programa, et voilà! a partir de ahora podemos gestionar nuestro prometedor repositorio desde esta más que correcta herramienta, veremos cómo evoluciona.
