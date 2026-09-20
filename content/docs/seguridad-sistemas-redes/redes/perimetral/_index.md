---
weight: 2
title: Seguridad Perimetral
---

# Seguridad Perimetral

En esta sección veremos cómo funcionan las herramientas de seguridad perimetral más utilizadas en entornos corporativos, sus problemas típicos de configuración y cómo evitarlos.

> [!COMMENT]
> En esta sección del curso no veremos proveedores de soluciones de seguridad perimetral comerciales específicos. Solo nos limitaremos a revisar características comunes de ellos, enfocándonos en la configuración de versiones libres que sigan paradigmas similares.

## Redes Internas vs. Perimetrales

Recordando lo visto en **Principios de seguridad**, es normal considerar cierta parte de la red de una institución como una "red interna", es decir, una red a la cual solo unas pocas personas tienen acceso. Dependiendo de la infraestructura de la institución, esta red puede configurarse de distintas formas:

* **Infraestructura _on premise_**: Llamamos Infraestructura _on premise_ a la infraestructura física (servidores, data-centers, switches de red, firewalls, almacenamiento, etc.) que una institución arrienda o compra y administra (o delega su administración) de forma tradicional
* **Infraestructura _en la nube_**: En este caso, es posible configurar en los mismos dashboards del proveedor distintas redes virtuales privadas (_VPCs_), con sus propias subredes, permisos de ruteo, grupos de seguridad y reglas de firewall.

El objetivo de las tecnologías de seguridad que veremos es proteger los espacios que conectan las redes internas con la red externa. Estos espacios son imposibles de evitar si queremos ofrecer servicios a personas fuera de nuestro límite de confianza, o si queremos acceder a nuestros sistemas de forma remota, para lo que se toman ciertas medidas que reducen al máximo la superficie de exposición y los potenciales problemas que pueden existir en ella.

## Firewall Tradicional

Un _firewall_ es como una _aduana de las redes_. Para cada paquete que desea entrar a la red o salir desde la red, revisa un conjunto de propiedades definidas en las _reglas de firewall_. Si todas las reglas se cumplen, se permite el tráfico.

A continuación nombramos algunos tipos de reglas típicos en los firewall perimetrales:

* **IPs y Subredes de Origen/Destino**: En el caso de reglas de salida, es útil para bloquear el acceso a cualquier IP o subred a la que no debería conectarse el sistema, ya que estas que pueden ser usadas por atacantes para exfiltrar información o mantener acceso después de lograr ejecutar código. En el caso de reglas de entrada, esto se puede usar para realizar _geofencing_, es decir, que el acceso a ciertos servicios expuestos se pueda hacer solo desde ciertos países (asumiendo que existe una forma más o menos confiable de asociar un país a una IP)

> [!TIP]
> ¿Qué puede hacer un atacante para saltarse una restricción de _geofencing_?

> [!TIP]
> ¿Qué impacto negativo puede tener, por ejemplo, que un servicio del Estado de Chile quede bloqueado para su acceso desde otras partes del mundo?

* **Protocolos y Puertos de origen/destino**: Es posible bloquear la comunicación de entrada y salida desde y hacia Internet asociada a ciertos puertos específicos en los protocolos TCP y UDP. También es posible bloquear todas las comunicaciones ICMP, lo que limita la capacidad de hacer PING entre dos redes separadas por un firewall con este bloqueo.

  Algunas personas administradoras de sistema lo hacen para hacer más difícil a un atacante reconocer los dispositivos conectados a una red, pero al mismo tiempo dificulta un montón el diagnóstico de problemas en las redes con esta configuración.

  En el caso de redes de salida, se usa a veces para prohibir la comunicaciones de servicios no deseados por instituciones, como Torrent y juegos en línea.

> [!COMMENT]
> Las comunicaciones por videollamada casi siempre usan puertos poco convencionales. Estos puertos suelen estar bloqueados en redes corporativas para casi toda IP, excepto para IPs de proveedores de videollamada conocidos como Google, Microsoft, Zoom y Cisco. 

> [!COMMENT]
> La mayoría de los proveedores de internet residencial bloquean algunos puertos _aguas arriba_ (es decir, en el firewall más al borde de sus sistemas autónomos, en contraposición a _aguas abajo_: más cerca del usuario final) que suelen ser usados por atacantes que infectan computadores de usuarios para abusar de recursos computacionales. Uno de los casos más típicos es el envío de Spam, para lo cual se requiere acceder al puerto 53 de un equipo configurado como _relay de correo_ (veremos esto con más detalle en la sección correspondiente).

> [!COMMENT]
> Piensa en alguna estrategia como atacante que ya ingresó a una red interna para conectarte a un servidor externo en una red que bloquea la comunicación a todos los puertos externos, excepto el 80 y el 443.

* **Segmentación de redes internas**: A través de las reglas de bloqueo de IP o subred es posible segmentar (de forma virtual) las redes internas de una institución. Para que esto sea más fácil, se recomienda colocar en subredes distintas distintos tipos de servicios. Una subred podría contener a todos los computadores de los trabajadores, y estar configurada para que ningún equipo de un trabajador o trabajadora pueda conectarse a los equipos de sus colegas. Otra subred podría contener la intranet de todos los y las empleadas, y otra subred podría contener herramientas internas que solo usa el equipo de desarrollo de la empresa.

> [!TIP]
> ¿De qué le puede servir a un atacante conectarse a equipos de otros usuarios desde el equipo de un usuario?

* **Permisos por día/hora**: Algunos firewall permiten habilitar/deshabilitar las reglas anteriores para ciertos días y horas específicas. Por ejemplo, se podría bloquear todo acceso a internet en los equipos de usuario los fines de semana si nadie trabaja esos días. 

* **Habilitación por puertos/MACs**: Otro filtro aplicable en los firewall de capa 3 y 4 (en sistemas _on premise_) es limitar o permitir la conexión a ciertos puertos físicos de los firewall solo a equipos con ciertas MAC. De esta forma se dificulta a un atacante con acceso físico el conectar un equipo infectado en un puerto de red desocupado.

* **VLANs asociadas** Una VLAN o red virtual permite segmentar aún más ciertas redes o subredes, permitiendo su acceso solo desde ciertos puertos específicos del firewall. De esta forma, se le dificulta a un atacante cambiar la IP de un equipo de usuario infectado para que se conecte a la subred de los servidores, siempre y cuando el punto de red del equipo del usuario no permita tráfico ni conexión a la VLAN administrativa.

* **Registros de red**: Para ciertas reglas, puede convenir más que realizar un bloqueo el avisar al equipo de TI de la existencia de tráfico que las gatilla. Esto puede dar a conocer un incidente en curso o un comportamiento anómalo antes de que se transforme en una brecha de seguriudad.

Estas son las recomendaciones generales para configurar un firewall tradicional:

* **Bloqueo por defecto, acceso granular**: Un firewall debería prohibir conexiones entre todo lo que no esté explícitamente permitido. A estas reglas se les denominan _block by default_. 
> [!TIP]
> ¿Qué puede hacer un atacante si un firewall está configurado en modo _allow by default_ (lo contrario a _block by default_)?

* **Segmentación de redes por tipo de usuario y por criticidad de infraestructura**: No cualquier usuario debe poder conectarse a cualquier servicio en la red interna. A esta situación no deseada se le conoce como _red plana_. Por un lado, se recomienda que los usuarios y dispositivos tengan acceso a través de red solo a la infraestructura de la red interna que necesitan para trabajar. Por otro lado, se recomienda que los dispositivos más críticos (IPs de hipervisores y paneles de administración) estén en redes distintas o con bloqueo de conexión a las redes de uso habitual.

* **Llevar registro de intentos de conexiones, no solo bloquear**: Con esto se pueden detectar muchos problemas de configuración o equipos infectados en la fase de exploración y reconocimiento del atacante, pero requiere configurar las reglas de tal forma de que disminuir al máximo los falsos positivos y falsos negativos.

> [!TIP]
> ¿Qué es lo peor que puede pasar con una red plana? ¿Qué puede hacer un atacante para aprovecharse de esto?

### _Next Generation Firewalls_

Desde hace casi una década, algunos firewall comerciales se han promocionado como _next generation firewalls_, ya que tienen características adicionales como las que mencionamos a continuación:

* **Listas categorizadas y bloqueo de dominios**: Los fabricantes llevan listas de Inteligencia de Amenazas, con IPs y dominios categorizados según su uso general (educación, redes sociales, gobierno, apuestas, pornografía, malware, etc). Esto permite bloquear contenido que no debería ser accedido (por temas de seguridad u otras razones) bloqueando las categorías generales y obligando a los equipos institucionales a usar el DNS interno (para detectar los dominios maliciosos).
> [!TIP]
> En algunas empresas, los equipos de seguridad informática se encargan de bloquear también sitios de apuestas, torrents, e incluso Youtube. ¿Es un riesgo de seguridad que los trabajadores puedan meterse a Spotify o Youtube? ¿Y a un sitio de torrents?

* **Bloqueo y alerta de conexiones anómalas**: Algunos proveedores de firewall detectan en tiempo real conexiones anómalas o con patrones de comportamiento sospechosos de todos sus clientes, y usan esta información para detectar campañas maliciosas en tiempo real. 

> [!COMMENT]
> Parece que las empresas que prestan seguridad de redes se benefician de tener cada vez más clientes por la cantidad de información de inteligencia de amenazas que pueden recibir de todos ellos, siendo cada uno una _sonda_ con la que pueden monitorear el comportamiento de los actores de amenaza. Sin embargo, casi siempre el acceso a estos feeds de información es considerado como un servicio adicional bastante caro 🫠

* **Deep Packet Inspection**: En algunos entornos empresariales más restrictivos, los equipos corporativos llevan instalados certificados autofirmados internos de la institución, **los que permiten ver el contenido de las comunicaciones incluso cuando estas son a través del protocolo TLS.**

 Hoy en día, la mayor parte de las comunicaciones de Internet importantes (Correo, Web) son a través de canales cifrados, los cuales se basan en una tecnología llamada _Transport Layer Security_ o TLS. Veremos esta tecnología con más detalle en la sección _Aplicaciones Criptográficas_ del módulo correspondiente. Lo importante para esta sección es saber que, si uno acepta una _autoridad certificadora_ arbitraria, ésta podrá "hacerse pasar" por cualquier sitio o proveedor que use TLS y abrir la comunicación cifrada antes de que llegue a destino, sin que el usuario se de cuenta fácilmente de que esto está pasando.

 Lo que podría interpretarse como un ataque sofisticado de un actor de amenaza también puede ser usado por una persona administradora de redes para ver el contenido de las comunicaciones internas de todos los equipos conectados, buscando en tiempo real comportamiento sospechoso (exfiltración de información, comandos de C2, etc) y bloqueándolo, pero también exponiendo a la exfiltración de comportamiento no malicioso pero sí sensible, como conversaciones de chat, correos electrónicos e y contraseñas, por lo que se recomienda a los empleados **no conectarse a sistemas personales en infraestructura que permite la inspección profunda de paquetes de red**.

## Firewalls de aplicación: Web Application Firewall (WAF), Proxy DNS y Filtros AntiSPAM de Correo

Así como un firewall tradicional puede interceptar y bloquear paquetes según el contenido de sus cabeceras de capa 3 y 4, los firewall de aplicación suelen interponerse entre el emisor y el servicio final y actuar como una _aduana_ pero con más atribuciones: las de abrir los paquetes en busca de contenido sospechoso y prohibir su ingreso en caso de confirmar estas sospechas.

En el caso de aplicaciones web, esta protección puede estar asociada a un _web application firewall_, el que actua como _proxy_ de todas las comunicaciones entrantes y salientes, detectando en cabeceras, cuerpo o parámetros HTML contenido sospechoso de servir para la explotación de una vulnerabilidad, o en la respuesta el resultado de una vulnerabilidad explotada. En el caso de DNS, se pueden usar servicios internos o externos que interceptan y bloquean ciertas consultas a dominios sospechosos o maliciosos (similar a los servicios de los _next generation firewalls_ de la sección pasada, pero no proveídos necesariamente por un firewall). En el caso del correo electrónico, existen servicios de filtro de correo AntiSPAM que "protegen" la IP real del servidor del correo, actúan como si fueran el servicio autoritativo para abrir todos los mensajes entrantes y salientes y bloquearlos si cumplen ciertas reglas que los vuelvan sospechosos.

> [!COMMENT]
> ¿Espera, y en qué se diferencia esto del _Deep Packet Inspection_ del caso anterior?

En el caso de _Deep Packet Inspection_ El/la administradora de redes puede ver el contenido de **todo el tráfico en tránsito por sus redes**, pero no puede ver el tráfico de personas que usen otras redes (por ejemplo, compartiendo internet con su móvil). En el caso de un _Web application firewall_, el proveedor del WAF puede ver el tráfico de **todos los usuarios legítimos del servicio**, independiente de la red de la que provengan. Ambos de todas formas funcionan como un _Person in the Middle_, interceptando tráfico cifrado e impersonando tanto emisor como receptor en ese proceso.


Para configurar correctamente estas herramientas, se suelen seguir las siguientes recomendaciones:

* **Bloquear el acceso desde IPs distintas a las usadas por el WAF/Proxy DNS/AntiSPAM**: Si la IP del servicio original se mantiene expuesta a todo el mundo, un atacante hábil podrá saltarse el WAF/Proxy DNS/AntiSPAM consultando directamente la IP original. Para evitar esto, se suele configurar el firewall perimetral de tal manera que solo permita conexiones al servicio protegido desde las IP declaradas por el servicio proxy.
* **Usar un proveedor confiable**: El proveedor de estos servicios tendrá acceso a los datos transmitidos de entrada y salida, pudiendo modificarlos si quisiera o pudiendo afectar su disponibilidad al menos hasta que la institución protegida pueda cambiar su configuración para no depender del proveedor. Es importante que la institución sepa qué tanto se está confiando en el proveedor y que asuma el riesgo sobre las propiedades de ciberseguridad de la institución si el proveedor es afectado por un incidente de ciberseguridad.

## Anti-DDoS

Algunos WAF comerciales vienen también con el servicio de _Anti-DDoS_, que no es más que proveer una capa previa a la aplicación final que detecte posibles ataques de denegación de servicio y los detenga antes de enviarlos a la aplicación potencialmente vulnerable.

En este caso, un ataque de denegación de servicio ocurre cuando un atacante logra afectar la disponibilidad de un servicio de Internet. Esto casi siempre es a través de coordinar un montón de equipos infectados o _zombie_ para que se conecten a un sitio determinado en un intervalo muy corto de tiempo. Si el servidor que entrega el servicio o el enlace de red no dan abasto para la cantidad de consultas simultáneas recibidas, éste puede caerse y dejar de funcionar durante el ataque o hasta que el proveedor lo reinicie. Un Anti-DDoS suele configurarse _delante_ del servicio original y permite determinar de forma eficiente este tipo de ataques, mientras está conectado a un enlace lo suficientemente robusto como para aceptar muchas conexiones.

En este caso, aplican las mismas medidas de protección que en la sección anterior.

## VPN Corporativa

En la Pandemia de COVID-19 de 2020, muchas instituciones acostumbradas al trabajo presencial tuvieron que adaptarse a hacerlo de forma remota en muy poco tiempo. En los casos en los que se pudo implementar de mejor forma, se utilizaron _VPNs Corporativas_, generalmente administradas por los dispositivos de seguridad perimetral de las instituciones (si su infraestructura era _on premise_) o a través de servicios adicionales de los proveedores de nube (si su infraestructura era _cloud_).

Una VPN Corporativa permite a una persona autorizada conectar un computador (personal o laboral) a la red institucional, a través del uso de sus credenciales del trabajador. En la práctica, un computador conectado a la VPN corporativa puede tener los mismos accesos de red que un computador conectado a la red interna de la institución.

Como el acceso a las VPN Corporativas está mucho más expuesto que el acceso físico a una oficina, es muy importante cuidad que no sea otorgado a personas no autorizadas, ya sea a través del uso de credenciales filtradas de empleados o de vulnerabilidades en dispositivos de seguridad perimetral no parchados.

A continuación dejamos algunas recomendaciones para limitar al máximo los riesgos de desplegar VPNs corporativas:

* **Parchar los equipos de seguridad perimetral constantemente**: En muchos casos, los accesos no autorizados se obtienen abusando de vulnerabilidades en los dispositivos de seguridad perimetral o en el software de VPN. Para evitar estos problemas, se recomienda mantenerlos actualizados y usar solo dispositivos que sigan siendo mantenidos por sus fabricantes.
* **Limitar su acceso a IPs específicas**: Si el acceso a la VPN es solo desde un país, bloquearlo desde IPs de otros países ayuda a disminuir la superficie de exposición, dificultando su ataque automático.
* **Segmentación de redes por perfil de usuario**: La segmentación de un usuario conectado por VPN debería ser la misma o una más estricta que la segmentación conectado físicamente a la red. Los dispositivos administrativos no deberían ser accesibles por usuarios de VPN que no requieren usar estos accesos, de modo de dificultar a un atacante que, a través de la vulneración de una cuenta de un usuario regular, pueda intentar vulnerar un panel administrativo.
* **Usar claves robustas**: Las claves usadas para conectarse a la VPN deben ser robustas y no estar presentes en filtraciones de datos conocidas. 
* **Usar MFA**: Una clave robusta no es suficiente para limitar el acceso a un recurso tan crítico como una VPN. Como se ve en la sección de autenticación y autorización, se recomienda usar al menos un tipo de factor adicional (como TOTP o Passkey).
* **Usar solo equipos institucionales**: Los equipos que se conectan a las VPN institucionales deben contar con herramientas de seguridad de _endpoint_ instaladas, para disminuir la probabilidad de contar con malware instalado en ellos. Un dispositivo con malware conectado a una VPN puede ser usado por un atacante de la misma forma que si tuviese las credenciales necesarias para acceder por su cuenta, y malware como _infostealers_ puede servir a los atacantes para robar usuarios, credenciales y URLs de acceso. Como una institución no puede tomar medidas de seguridad sobre los equipos personales de sus trabajadores, lo mejor es prohibir que estos equipos se conecten a recursos del trabajo.

## El modelo de arquitectura _Zero-Trust_

En algunos casos, se habla del modelo _zero trust_ como una alternativa a la seguridad por capas que se usa tradicionalmente. Este modelo requiere que los sistemas no confíen que los usuarios son quienes dicen ser solo por estar en una red interna o porque un paso anterior los verificó, revalidando los recursos, permisos y accesos antes de realizar acciones críticas. NIST lo define en el [SP 1800-35](https://pages.nist.gov/zero-trust-architecture/) y el [ETSI](https://www.etsi.org/about/) (Instituto Europeo de Estándares en Telecomunicaciones) [desarrolló una guía el 2025 sobre cómo aplicarlo](https://www.etsi.org/deliver/etsi_ts/104100_104199/104102/01.01.01_60/ts_104102v010101p.pdf).


En cierto sentido, ambas definiciones consideran tanto el principio de mínimo privilegio como el principio de mediación completa, ambos vistos anteriormente en el curso, y si bien sería ideal que toda organización tuviese tan claros sus procesos de almacenamiento y transmisión de información además de los permisos involucrados, partir con _zero trust_ en una organización antigua pero no muy madura en ciberseguridad puede ser mucho más difícil que partir con herramientas de seguridad perimetral.

> [!TIP]
> De lo poco que hablamos de Zero Trust, comenta qué supuestos mantiene frente a otros modelos de seguridad, los cuales en el caso de no ser cumplidos dificultan la tarea de evitar accesos no autorizados a sistemas internos de una organización.

