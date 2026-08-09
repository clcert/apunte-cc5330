---
weight: 2
title: Principios de Ciberseguridad
---

# Principios de Ciberseguridad

Esta sección habla de un solo paper llamado "[The protection of information in computer systems](https://ieeexplore.ieee.org/document/1451869)" (Descargable desde la red de la U), escrito por J.H. Saltzer y M.D. Schroeder en el año 1975.

A continuación presentamos 10 principios que aplican al diseño de sistemas y desarrollo de software hasta el día de hoy.

## Principio de Economía de Mecanismos

* **Objetivo**: Mantener el sistema lo más pequeño y simple posible.
* **Supuesto**: Sistemas complejos y con muchas piezas aumentan la superficie de ataque y la probabilidad de fallos, ya que es más difícil tener a la vista todas las posibles interacciones entre los componentes.
* **Ejemplos**:
 * Principio de diseño KISS (_Keep it simple, stupid!_ en su versión original o _Keep it short and simple_ en su versión menos ofensiva). 


## Principio de Valores por defecto Seguros

* **Objetivo**: Que los valores predeterminados del sistema sean seguros.
* **Supuesto**: Quienes tienen menos experiencia en usar el sistema suelen ser los más vulnerables a su funcionamiento incorrecto y no  intentarán cambiar sus configuraciones.
* **Ejemplos**:
  * Hace unos años, al inicio de la Pandemia de COVID-19, [Zoom mostraba los números de las reuniones al compartir pantalla y no defínía contraseña por defecto](https://www.theverge.com/2020/4/8/21214042/zoom-update-meeting-id-privacy-security-access-code). Esto permitía a cualquier persona viendo una transmisión unirse a la llamada y hacer _Zoombombing_.


## Principio de Falla Resiliente
* **Objetivo**: Si un sistema falla, éste debería caer en un estado _seguro_ y recuperarse de forma gradual.
* **Supuesto**: Las cosas fallan o son mal configuradas por error. Esto no debería implicar inseguridad. Volver a la operación normal debería ocurrir rápido.
* **Ejemplos**
  * Las puertas automáticas del Edificio Poniente (Beauchef 851). Si se corta la luz, ¿se deberían mantener abiertas o cerradas?
  * En la película _Duro de Matar_ (buen ejemplo sobre el uso de espacios de una forma distinta a la diseñada por quien los creó), cortar la energía eléctrica del _Nakatomi Plaza_ desactiva la cerradura de la bóveda de seguridad del edificio. Me encanta la película pero, ¿Quién diseñó esa bóvedaaa? 🫠

## Principio de Mediación Completa
* **Objetivo**: El acceso a cada componente debe contemplar una revisión de permisos correctos en todo momento.
* **Supuesto**: Las condiciones de acceso pueden cambiar durante la ejecución de una acción.
* **Ejemplos**:
  * Los permisos de un usuario se validan solo al momento de iniciar sesión en un sistema administrativo. Si esta persona pierde la confianza de quien administra el sistema y le quitan los accesos, se espera que no pueda ejecutar ninguna acción en el momento en que se aplica la medida de restricción. _¿Qué pasaría si el acceso se determinara por un JWT con una duración de 24 horas?_

## Principio de Diseño Abierto
* **Objetivo**: Una clave debe ser lo único secreto en un sistema para conservar su seguridad.
* **Supuesto**: Un adversario podrá obtener, tarde o temprano, el diseño del sistema; ya sea por filtración, ingeniería reversa o cualquier otro mecanismo.
* **Ejemplos**:
  * Principio de Kerckhoffs (Siglo XIX): _Un sistema criptográfico debe ser seguro incluso si se conoce públicamente su implementación, siempre y cuando la llave se mantenga secreta_. Cambiar un valor que funciona como llave si se filtra es mucho más fácil y barato que cambiar un mecanismo.
  * Claude Shannon (Siglo XX): _El Enemigo conoce el sistema_. Si lo diseñó una persona, casi seguramente otra persona podrá entender cómo funciona.

## Principio de Separación de Privilegios
* **Objetivo**: Separar en varios responsables cada parte de un sistema, o requerir más de un responsable para operar un sistema.
* **Supuesto**: Es más difícil que se filtren varios accesos independientes a la vez a que se filtre un solo acceso.
* **Ejemplos**:
  * Autenticación multifactor (lo veremos en la próxima clase): Si los factores no dependen entre sí, que un atacante los consiga todos es más difícil a conseguir solo uno.
  * Puertas en las que hay que contar con más de una llave para abrirlas: Si se pierde una llave solamente, la puerta sigue sin poder abrirse.
  * Llaves distintas para puertas distintas, manejadas por personas distintas. Si se pierde una llave, lo que puede hacer una persona que la encuentre es mucho menos que si esa llave sirviera para todas las puertas.

## Principio de Mínimo Privilegio
* **Objetivo**: Contar con más privilegios que los mínimos necesarios para hacer las tareas encomendadas es un riesgo.
* **Supuesto**: Si la cuenta con privilegios es vulnerada, el minimizar los privilegios disminuye la superficie de ataque.
* **Ejemplos**:
  * _Scoping_ de permisos en aplicaciones móviles (lo veremos en la unidad correspondiente)
  * Limitar privilegios administrativos a la menor cantidad de cuentas posible, y usar esas cuentas lo menos posible para evitar que sean vulneradas.

##  Principio de menor cantidad de mecanismos comunes
* **Objetivo**: No compartir estados o variables entre muchas partes distintas del sistema.
* **Supuesto**: Si el mecanismo es vulnerado, puede permitir saltar a otras partes del sistema, o puede afectar a muchos sistemas simultáneamente.
* **Ejemplos**:
  * Librerías compartidas a las que se les encuentran vulnerabilidades
  * Software popular (Wordpress, Windows), que no es necesariamente más inseguro, sino que es más revisado por buscadores de vulnerabilidades por el impacto que éstas pueden tener en más sistemas.

## Principio de Defensa en Profundidad
* **Objetivo**: Diseñar sistemas con más de una capa de seguridad en lugardes distintos. 
* **Supuesto**: Si una capa cae, las otras permanecen.
* **Ejemplos**:
  * Frente a una vulnerabilidad en el intérprete Javascript de un navegador, deberían existir los siguientes controles:
    * Sandboxing en navegadores
    * Limitación de comunicación entre procesos
    * Limitación de instalación de firmware malicioso en el hardware
    * Red monitoreando intentos de infección a otros equipos.

> [!TIP]
> Piensa en casos (relacionados con computadores o no) en los que te has encontrado con este principio. En alguno de ellos, ¿recuerdas que una capa haya fallado y una más interna haya actuado?

## Principio de Aceptabilidad Psicológica
* **Objetivo**: Las medidas de seguridad deben ser amigables para el usuario. Si no, no serán usadas.
* **Supuesto**: Las personas terminan ignorando o intentando saltarse advertencias repetitivas, molestas y poco claras.
* **Ejemplos**:
  * Bloqueos de sitios en firewalls institucionales: Si se bloquean sitios necesarios para trabajar (como un sistema de subida de archivos), las personas recurren a medidas más peligrosas para hacer lo que tienen que hacer (conectarse a la internet móvil, usar servicios desconocidos para compartir archivos, enviárselos por mensajería instantánea personal, etc)
  * [The Password Game](https://neal.fun/password-game/): 🥚


## Otros principios (con explicaciones crípticas)

* **Modularización y encapsulación**: Ya que los módulos son más fáciles de analizar y segurizar.
* **Reusar componentes seguros y conocidos**: _Más vale diablo conocido que santo por conocer_
* Seguridad y privacidad por diseño: Es más difícil agregar seguridad o privacidad en etapas finales de los proyectos.
* **Diseñar con capacidades evolutivas en mente**: Los algoritmos criptográficos cambian. Deben ser fáciles de cambiar (como los hashes para derivación de contraseñas)
* **Confiar, pero verificar primero**: Hasta los más confiables cometen errores y verificar algo suele ser barato o rápido (comparado con generar el valor).

>[!TIP]
> **Actividad**: Para cada uno de los casos siguientes, indica el principio que debería usarse o respetarse.
> 
> * Todo usuario creado en Windows XP (2001) operaba como administrador.
> * Cuando el servicio Playstation Network fue vulnerado, no se detectó la intrusión y el atacante pudo recuperar contraseñas en texto plano de 77 millones de usuarios.
> * Edward Snowden logró filtrar enormes cantidades de información clasificada de la NSA sin mayor impedimento.
> * El mecanismo de serialización de objetos de Java ha sido fuente de muchas vulnerabilidades, incluyendo ejecución remota.
> * En las vulnerabilidades de CPUs tipo Spectre y Meltdown, las CPU permitían a procesos acceder a memoria (alojada en el caché) que no debían.
> * El algoritmo WEP de seguridad inalámbrica fue quebrado cuando el cifrador asociado (RC4) fue analizado luego de ingeniería reversa.
> * El bug “heartbleed” de OpenSSL (2014) surge del subprotocolo “heartbeat”,  una extensión muy simple dentro de un módulo de 500 mil líneas de código.
> * Windows UAC en Vista (2007) por default mostraba una ventana pop-up para autorizar todo cambio que requiriera autorización, lo cual era frecuentemente deshabilitado.
> * Muchas aplicaciones web hacen expirar las contraseñas de los/las usuarios luego de 60 o 90 días.  
> * El robo de datos de Equifax del 2017 se caracterizó por lo rápidamente que los atacantes pudieron moverse de un computador a otro hasta encontrar uno con toda la base de datos de clientes.
> * Muchos dispositivos IoT han sido vulnerados debido a la reutilización de credenciales conocidas (expuestas, copiadas) previamente.
> * La Apps de Android comenzaron a solicitar privilegios granulares recién a partir de la versión 6.0.
