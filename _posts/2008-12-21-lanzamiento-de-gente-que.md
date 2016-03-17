---
id: 256
title: Lanzamiento de Gente QUÉ
date: 2008-12-21T18:07:29+00:00
author: fer
layout: post
guid: http://www.usuariodeinternet.es/?p=256
permalink: /profesional/lanzamiento-de-gente-que
categories:
  - Profesional
tags:
  - advernet
  - comunidad
  - que
---
 <img src="http://www.usuariodeinternet.es/img/post/genteque.gif" alt="Gente QUÉ" title="Gente QUÉ" width="200" height="150" style="float: left; margin-right: 10px;" />Tras un par de meses de desarrollo intenso, y otro par de semanas de rush final demencial (sin los lanzamientos ésto no sería tan divertido), ve la luz, por un lado, el <a title="Web del Diario QUÉ" href="http://www.que.es/" target="_blank">rediseño de la web del Diario QUÉ</a>, y por la parte que nos toca, su estrenada y flamante plataforma de comunidad, <a alt="La comunidad del QUÉ" title="La comunidad del QUÉ" href="http://gente.que.es" target="_blank"><strong>Gente QUÉ</strong></a>.

En un mercado con muchos medios tradicionales aferrándose a un papel que cada vez huele más a muerto, el QUÉ se lanza en bomba a la piscina con una estrategia innovadora y apostando con fuerza por el **usuario**.

En líneas generales, la primera fase, el core del proyecto, es una **plataforma de single sign-on** que permite al usuario tener su perfil en Gente QUÉ y utilizar dichas credenciales para acceder a cualquiera de los servicios que se integren con la plataforma, de manera que cuando te logueas en uno, la sesión se mantiene durante toda la navegación por el &#8220;ecosistema&#8221; que se está montando alrededor del QUÉ.

Dejando de lado el análisis pseudo-gurú, desde el punto de vista del desarrollo yo destacaría las siguientes funcionalidades:

<ul style="padding-left: 30px;">
  <li>
    <strong>ID ÚNICO</strong>. Con la facilidad de uso para el usuario en mente se ha integrado el <a href="http://gente.que.es/login.php">logueo a través de sistemas externos</a>, en concreto, con <strong>Facebook, Windows Live, Yahoo y OpenID</strong>, de manera que una vez autenticado en uno de ellos se puede registrar una cuenta en Gente que quedará ligada a dicho ID, pudiendo a partir de entonces utilizar todos los servicios del QUÉ accediendo a través de tu usuario de Facebook, por ejemplo ¡no más contraseñas desperdigadas por Internet! <p style="margin-top:10px;">
      Una de las mayores complicaciones de esta parte era implementarlo de forma que el usuario lo entendiera, que no se mareara cuando de repente se le redirige a una página externa, y que pudiera darse cuenta de los beneficios que tiene esta funcionalidad. Considero que lo hemos conseguido simplificando el proceso al máximo, aunque es verdad que debemos pulirlo en las fases que vendrán.
    </p>
    
    <p>
      Lidiar con las APIs de cada servicio ha sido una de cal y otra de arena. Para variar, hacer algo con Windows Live es un picor constante en busca de documentación decente e intentando resolver comportamientos demenciales. El resto chapó. También las hemos utilizado para obtener los contactos de las cuentas e <a href="http://gente.que.es/invitar_contactos.php?men=ok">invitar a nuevos amigos</a>. En breve haré un post explicando con detalle cómo integrar cada uno de ellos.
    </p>
    
    <div style="text-align: center;margin:10px;">
      <img width="552" height="81" src="/img/post/gente_contactos.gif" alt="La funcionalidad de importar contactos desde servicios externos" title="La funcionalidad de importar contactos desde servicios externos" />
    </div>
  </li>
  
  <li>
    <strong>LIFESTREAMING</strong>. Tal vez la característica más diferenciadora respecto a iniciativas de otros medios sea ésta de registrar la actividad que generan los usuarios en los servicios integrados en la plataforma. Cuando se llega al punto en que hasta los de <a href="http://robdolin.spaces.live.com/blog/cns!3C8CA60F8F925FEC!3140.entry">Windows Live salen del caparazón</a>, era un paso lógico para el QUÉ, ya que tenían centralizado el login, hacer lo mismo para la <a href="http://gente.que.es/pulso.php">actividad del usuario</a>. <p style="margin-top:10px;">
      En gran parte relacionada con esta funcionalidad está la de <strong>comunidad</strong>, con la posibilidad de seguir a usuarios y por lo tanto, su actividad. En esta primera fase las relaciones quedan limitadas a ésto, pero habrá muchas novedades en este sentido en breve.
    </p>
    
    <div style="text-align: center;margin:10px;">
      <img width="552" height="81" src="/img/post/gente_actividad.gif" alt="La actividad del usuario en Gente QUÉ" title="La actividad del usuario en Gente QUÉ" />
    </div>
  </li>
  
  <li>
    <strong>BARRA DE USUARIO</strong>. Los servicios que se integran con Gente QUÉ debían tener alguna <em>marca</em> que así los identificara, y también con la necesidad de ofrecer un acceso rápido a las funcionalidades de la plataforma, se desarrolló esta barra <em>inspirada</em> en la de Facebook. Ahora mismo ofrece simplemente eso, accesos directos, pero es una de las partes del proyecto que más añadidos y atención va a recibir en los próximos meses, estoy seguro. Podéis verla por ejemplo desde la misma <a href="http://www.que.es">portada del QUÉ</a>. <p style="margin-top:10px;">
      Para nosotros el mayor reto fue implementar todo el tinglado con <strong>javascript</strong>, con pequeñas pijaditas como los tooltip informativos y grandes brownies como controlar si hay una sesión iniciada en Gente QUÉ desde servicios externos o idear una forma de sincronizar dicha sesión con la local, pero vamos, esto es material para otro post.
    </p>
    
    <div style="text-align: center;margin:10px;">
      <img width="552" height="81" src="/img/post/gente_barra.png" alt="La barra de usuario de Gente QUÉ" title="La barra de usuario de Gente QUÉ" />
    </div>
  </li>
  
  <li>
    <strong>APIs</strong>. Desde el principio teníamos claro que estábamos haciendo una plataforma de servicio, así que todas las funcionalidades son accesibles a través de APIs propias, de manera que cualquier servicio externo se puede integrar de forma prácticamente transparente con la plataforma de forma sencilla y rápida. Un total de <strong>más de 15 APIs</strong> y 30 páginas de documentación dan fe de lo grande que es este proyecto y la casi total flexibilidad que ofrece para futuras integraciones y cambios. <div style="text-align: center;margin:10px;">
      <img height="81" width="552" alt="Diagramas de flujo de las APIs" src="/img/post/gente_apimini.gif" title="Diagramas de flujo de las APIs" />
    </div>
  </li>
</ul>

Para nosotros ha sido un proyecto complicado, pero con el que sobre todo **hemos aprendido mucho**. Cuando te metes en desarrollos de este tipo, tan dinámicos y con programadores de todos los niveles, se descubren enseguida las carencias en la metodología de trabajo que puedas tener. Ahora es cuando nos vamos a plantear implantar cosas de esas que usan los profesionales con carrera (framework, subversion, gestión avanzada de bugs&#8230;), hasta ahora hemos podido pasar sin ellas, pero la cosa se pone seria!