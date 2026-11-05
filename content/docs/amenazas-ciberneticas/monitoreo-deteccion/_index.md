---
weight: 3
title: Monitoreo y detección de amenazas
---
> [!IMPORTANT]
> 👷 **En construcción**: Esta página es un boceto, pero es suficiente para la versión actual del apunte.

# Monitoreo y detección de amenazas

> [!COMMENT]
> Para más información del monitoreo y derección de amenazas desde la red, ver el capítulo de seguridad de redes. En este capítulo nos enfocaremos en el monitoreo con otras herramientas. 

En este capítulo hablaremos brevemente de algunas herramientas usadas para detectar amenazas durante su infiltración o antes de que generen un impacto en la infraestructura de la víctima.

## Herramientas

* **Antivirus**: Aplicaciones que monitorean la ejecución de otras aplicaciones y/o creación de archivos, y si detectan ciertos patrones de comportamiento, limita su ejecución o elimina el archivo. Algunos de los patrones detectados son:
  * Hashes de los archivos. Estos se comparan con una base de datos que se actualiza regularmente. Sin embargo, no es una buena medida de prevención, ya que para cambiar completamente el hash de un archivo basta con agregarle un byte. 
  * Estructuras en memoria o en el archivo: algo menos estricto que un hash criptográfico, pero que puede
  * Modelos estadísticos sobre el comportamiento del archivo: si al abrirse el archivo modifica el registro, ejecuta comandos con privilegios y se conecta con IPs desconocidas, se puede bloquear el proceso que ejecuta estas acciones.
* **SIEMs**: _Security Information Event Manager_, es un tipo de software que recopila y agrupa los _logs_ de todos los sistemas, especialmente aquellos que podrían ser síntomas de incidentes de ciberseguridad en curso.
* **MDMs**: _Mobile Device Management_, herramientas que permiten controlar equipos institucionales, desde la instalación deperfiles personalizados hasta su bloqueo y formateo en caso de pérdida. 
* **EDRs y XDRs**: Significa _Endpoint Detection and Response_. Son herramientas similares a los clásicos antivirus pero que suelen monitorear más que solo los archivos creados o borrados. Además, permiten a un administrador o administradora de sistema ejecutar comandos remotos en los computadores que tienen el EDR instalado. Sus métodos de detección de comportamiento malicioso combinan múltiples fuentes (red, eventos del sistema, cambios en archivos críticos o registros) para determinar si algo es malicioso o no.
