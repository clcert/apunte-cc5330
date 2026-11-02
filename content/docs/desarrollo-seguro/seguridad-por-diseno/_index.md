---
weight: 2
params:
  bookCollapseSection: false
title: Seguridad por defecto y por diseño
---

# Seguridad por Defecto y por Diseño

El ideal en el desarrollo de software, sería considerar las propiedades de ciberseguridad (confidencialidad, integridad, disponibilidad) desde la toma de los requisitos y el diseño de la solución.

Si bien existen algunas características más o menos estándar, las cuales hemos visto en clases (no guardar contraseñas en texto plano, contar con métodos de MFA, llevar registros de las acciones realizadas en el sistema), a veces, determinar si algo es o no inseguro en un contexto específico depende fundamentalmente de las expectativas de los usuarios o clientes del sistema. 

Esas expectativas no siempre son claras, o si quiera consistentes entre los distintos tipos de usuarios. Esto facilita la aparición de debilidades, y con ello la posibilidad de encontrar vulnerabilidades, las cuales pueden ser más críticas mientras más dependientes sean del modelo inicial definido.

En esta sección hablaremos de ambas cosas: Por un lado, las características generales que hacen a unas aplicaciones "más seguras" que a otras. Por el otro, el impacto que tienen en la seguridiad de un sistema las herramientas de modelado y programación usadas al desarrollarlo.

## Seguridad por Defecto vs. Seguridad por Diseño

* **Seguridad por Defecto**: Hacer que las aplicaciones sean resilientes y seguras utilizando su configuración inicial “out of the box”. Si los usuarios se “alejan” de la configuración por defecto, deben estar conscientes de que aumenta la probabilidad de estar comprometidos. La “versión segura” del software no está disponible por un mayor precio, sino que viene de base en todos los productos (por ejemplo, el cinturón de seguridad en automóviles)

Algunas decisiones de desarrollo relacionadas con la seguridad por defecto (varias mapean con principios de ciberseguridad):
 - **Eliminar contraseñas por defecto**: Si el atacante sabe cuál es la contraseña por defecto de un sistema, puede intentar primero usarla para acceder a él. 
 - **Obligar el uso de MFA, especialmente para usuarios con privilegios administrativos**: Como vimos en el curso, MFA es una medida esencial para evitar accesos no autorizados en sistemas conectados a Internet. Estos accesos tienen un mayor impacto en cuentas con privilegios administrativos, por lo que se recomienda implementarlo al menos en este tipo de cuentas.
 - **Uso de single sign-on, a través de, por ejemplo, OIDC.**: Delega el problema de tener que tratar con datos sensibles (como contraseñas), facilitando al usuario acceder a múltiples sistemas con pocas credenciales. Como mencionamos en la sección de autentificación, hay que confiar mucho en la plataforma proveedora d**e identidad, ya que una vulneración a sus sistemas otorgará accesos a toda plataforma que confíe en ella para autenticarse.
 - **Uso de perfiles restringidos**: Primero, contar con la posibilidad de limitar el alcance de las acciones de un usuario evita su mal uso tanto de parte del usuario como de cualquier otra persona que consiga ese acceso. 
 - **Priorizar seguridad versus compatibilidad con versiones anteriores**: Muchas veces, con el objetivo de que el software sea retrocompatible, algunas opciones inseguras de configuración se mantienen en él, incluso existiendo opciones más seguras. Si estas opciones se mantienen como los valores por defecto, el impacto de modos de operación más seguro será muy bajo, ya que no es común que las personas que usan el software se dediquen a configurarlo de forma segura por iniciativa propia. Si estas opciones por defecto cambian, pero se siguen permitiendo modos de operación inseguros, es posible que las personas que usan los sistemas hagan el cambio porque alguien con poco conocimiento en seguridad se los recomienda para evitar complejidad en las configuraciones. Algunos lenguajes de programación, como Go, no implementan por defecto en sus librerías estándar protocolos criptográficos que se conocen inseguros para desincentivar su uso lo más que se pueda.

  > [!TIP]
  > Hablemos de PHP2Shell, una vulnerabilidad que afectaba a más de 10 años de versiones de PHP, pero que fue parchada oficialmente solo en las versiones que no estaban sin soporte de parte de la comunidad. ¿Es una buena idea ofrecer parches para las versiones más antiguas? ¿Por qué sí? ¿Por qué no?

 - **Considerar experiencia de usuario en la configuración de seguridad**: El ideal sería que el software funcionara de forma segura por defecto, sin que el usuario tenga que intervenir más allá de lo esencial para preservar las propiedades de seguridad buscadas. Si esto está desactivado por defecto, como ya hemos dicho, muy pocas personas lo activarán. Si está activado por defecto pero hace el software difícil de usar, muchas personas se esforzarán en desactivarlo sin entender bien el impacto de hacerlo.



* **Seguridad por Diseño**: Es un framework que entrega una guía estructurada que internaliza la seguridad durante la fase de diseño de sistema y arquitectura dentro del ciclo de vida de desarrollo del software (SDLC), entendiéndolo como el proceso de diseño, desarrollo y mejora continua del software.

Algunas decisiones de desarrollo relacionadas con la seguridad en el diseño de sistemas, interfaces y aplicaciones:
 - **Lenguajes de programación _memory safe_**: Si el lenguaje de programación usado no permite cometer ciertos tipos de errores (como acceder a espacios de memoria inválidos o sobreescribir espacios ejecutables), se elimina de raíz toda una categoría de vulnerabilidades que puede ser crítica.
 - **Uso de hardware seguro como TPM o HSM** El uso de TPMs y HSMs 
 - **Uso de componentes seguros de software (librerías, middlewares, entre otros)**: Algunos componentes es mejor usarlos de librerías reconocidas que desarrollarlos. 
 - **Uso de Frameworks Web**: Los Frameworks Web resuelven un montón de problemas de diseño de forma estandarizada, dando paso a menos espacios de error.
 - **Consultas SQL parametrizadas**: Esto impide desde el punto de vista del diseño del sistema la ejecución de consultas SQL externas.
 - **Testing estático y/o dinámico**: Correr continuamente herramientas que validan funcionalidades y comprueban (o descartan) un comportamiento peligroso.
 - **Revisión de código por parte de QA**: Un equipo separado al desarrollo debe revisar el código y determinar el impacto en la seguridad que tienen las nuevas funcionalidades.
 - **Programas coordinados de reportes de vulnerabilidades**: Si el software se diseña de forma abierta y sin esperar que la seguridad se mantenga por el secreto de su implementación, un programa de reporte coordinado de vulnerabilidades (se verá más adelante) aporta un montón a la seguridad del sistema a medida se van encontrando vulnerabilidades de forma colaborativa.
 - **Validación humana de todo software que será usado en producción**: Con el advenimiento de herramientas de IA generativa para el desarrollo de software, se hace mucho más importante que antes que un humano pueda leer, comprender y aceptar el código ejecutado en un sistema en producción. Algunas personas consideran que es suficiente con desarrollar mecanismos que atrapen errores más comunes cometidos por la IA generativa (como por ejemplo, usar tests muy específicos). Esto puede ser suficiente para algunos casos de uso menos riesgos, pero de todas formas es importante tener en cuenta el impacto de no comprender (al menos en alto nivel) el código ejecutado.

 > [!COMMENT]
 > ¿Pero tenemos que entenderlo todo todo? Mucho del trabajo de las personas qeu se dedican al desarrollo de software se basa en abstracciones. ¿No puede ser una abstracción la solicitud de requisitos de alto nivel realizada a un modelo de IA generativa?
 > 
 > Al menos, podemos convenir que, incluso si la consideramos una abstracción, es una abstracción muy distinta a otras que se estaban tomando hasta ahora en la disciplina, ya que sus resultados suelen ser no deterministas o difíciles de explicar.


> [!COMMENT]
> En pocas palabras: Seguridad por defecto es cuando el equipo de desarrollo sigue prácticas aceptadas y amplias que demostradamente limitan el la probabilidad y el impacto de vulnerabilidades y debilidades comunes gatilladas por los y las usuarias. Mientras que seguridad por diseño son las decisiones de diseño y funcionamiento del sistema (algunas comunes, otras específicas al contexto) junto con el proceso de desarrollo que limitan las posibilidades de las herramientas, haciendo menos probable que pasen cosas inesperadas.
