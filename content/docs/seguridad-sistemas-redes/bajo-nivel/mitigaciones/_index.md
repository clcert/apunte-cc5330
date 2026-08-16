---
weight: 4
title: Mitigaciones
---


# Mitigaciones

En las secciones de seguridad de bajo nivel, notamos un primer mayor origen de debilidades en software, el que tiene que ver con la confusión entre _datos externos_ y _código originalmente ejecutable_. Para mitigar este problema, se han definido varios mecanismos de seguridad (la mayoría de ellos, activados por defecto en la compilación de nuevos programas o en el comportamiento natural de sistemas operativos). A continuación listaremos varias de ellas.


## 🧢🧑‍💻 Como programador

* **Uso de lenguajes de programación que manejen la memoria de forma segura**: Lenguajes compilados como Rust y Go, o interpretados como Java o Python, manejan por defecto la memoria de forma segura, impidiendo el acceso a sectores arbitrarios de memoria. Lo anterior disminuye la probabilidad de vulnerabilidades de este tipo.
* **Evitar funciones de manejo de memoria inseguras** (_strcpy_, _strcat_, _memcpy_): En C, existen alternativas como `strncpy` y `strlcpy`, que permiten especificar el tamaño de bytes máximo que pueden ser copiados. Dependerá de su uso correcto el si son efectivas o no.

> [!TIP]
> Sugiere una forma de eliminar la efectividad de _strncpy_ a través de un ejemplo de código mal diseñado.


* **Usar flags de compilador seguras y/o versiones recientes de los compiladores**: Hay algunas medidas de seguridad que se aplican por defecto en las compilaciones de nuevos programas en C, como por ejemplo, los **Stack Canaries**. Estos son valores que se agregan al _stack_ en el proceso de inicialización de un nuevo _frame_, y luego se valida que no hayan sido modificados al momento de salir del frame. Si fueron modificados, el programa se termina. Hay muchos tipos de _canaries_:
  * **Canario al azar**: cada ejecución del programa define un valor de canario. De esta forma, el atacante no puede escribirlo por su cuenta en su payload.
  * **Canario terminator**: El canario incluye el byte nulo (`\x00`), de modo de evitar que lecturas de buffer no controladas pasen la sección de memoria en la que el canario se encuentra ubicado.
* **Sanitizar datos recibidos por un usuario**: Si se desarrolla una aplicación que puede almacenar información que, en ciertos contextos, podría ser interpretada como instrucciones y no como datos, se recomienda ejecutar medidas de sanitización en el proceso de ingreso y salida de estos datos, limitando los caracteres ingresables a un conjunto bastante acotado y/o eliminando los que no están en este conjunto seguro. Esto dificultará el aprovechamiento de vulnerabilidades que permitan controlar el flujo de un programa, en caso de existir.
* **Separar dominio de los datos del dominio del código**: En los casos en los que se pueda separar por completo el dominio de las instrucciones del de los datos desde el diseño del software, tomar esta decisión para evitar futuras apariciones de vulnerabilidades de control de flujo. Algunos lenguajes de programación _taguean_ las cadenas de texto que vienen de fuentes no confiables y no les permiten ser usadas en contextos específicos que pudieran gatillar vulnerabilidades.
* **Usar mecanismos de validación de código estáticos y dinámicos**: Los veremos con más detalle en la sección _desarrollo seguro_.

## 🧢🧑‍💻 Como administrador de sistemas

* **Activar medidas de seguridad en sistemas operativos**:
  * **ASLR o _Adress Space Layout Randomization_**: Cambia las direcciones de memoria de los programas por un _offset_ aleatorio, dificultando la predictibilidad del espacio de memoria al que hay que saltar en el caso de querer ejecutar shellcode o código ROP. Dependiendo de la arquitectura del sistema, la aleatorización puede ser burlable con fuerza bruta o muy difícil de burlar. (en x86, en muchos casos basta con realizar muchos intentos de explotación con una dirección específica hasta que el programa distribuya su memoria en una dirección cercana a la elegida).

  Esta medida de seguridad viene activada por defecto en todos los sistemas operativos modernos.

  * **W^X o _Write xor Execute_**: Configuración de sistema operativo que evita que las zonas de memoria escribible sean ejecutables y viceversa (también se conoce como DEP o _Data Execution Prevention_ en Windows y PaX en Linux). Su activación dependerá del tipo de sistema operativo y de las aplicaciones que haya que ejecutar en él (algunas aplicaciones requieren que sectores escribibles sean luego ejecutables por (mal) diseño). Mitiga ejecución de código almacenado en la sección de datos, pero no técnicas como _ROP_ o _return-to-libc_.
  * **Aislar aplicaciones entre sí**: En sistemas críticos, la recomendación es aislar la ejecución de aplicaciones en máquinas virtuales o servidores distintos. De esta forma, una vulnerabilidad crítica explotada no tiene efectos en otros sistemas.
  * **Syscall Randomization**: Para cada ejecución de la aplicación, cambian los códigos de syscalls en ese contexto, provocando que los _shellcode_ tradicionales no funcionen.
  * **Instruction set randomisation**: similar a _Syscall Randomization_ pero cambiando los códigos de máquina de la arquitectura correspondiente.
* **Mantener actualizados sistemas operativos y aplicaciones**: Esto aplica especialmente a sistemas operativos y aplicaciones expuestas a Internet, dado que la superficie de exposición es mucho más grande comparado al caso de aplicaciones de ejecución local. 


## 🧢🧑‍💻 Como fabricante de hardware

* **Hardware seguro por defecto**: Existen extensiones a arquitecturas conocidas, como [CHERI](https://cheri.cst.cam.ac.uk/), que intentan definir en la misma especificación del hardware (y el código de máquina correspondiente) estrategias que limiten el acceso no autorizado a memoria, tanto en términos de lectura/escritura como de ejecución.

## 🧢🧑 Como usuario

* **Usar sistemas operativos con actualizaciones continuas y hardware reciente**: Es inevitable que se encuentren vulnerabilidades tanto en software como hardware de dispositivos que usamos todos los días. Para evitar su explotación, la recomendación general es mantenerlos actualizados constantemente. Las últimas versiones de los sistemas operativos más usados (_Windows 11_, _Ubuntu 26.04_, _MacOS 26_) deberían ser las mejor configuradas para evitar vulnerabilidades de bajo nivel.
* **Actualizar aplicaciones continuamente**: Así como pueden haber vulnerabilidades en los sistemas operativos, estas también pueden afectar el software instalado en nuestros equipos que usamos comúnmente. Es por esto que es importante mantener actualizadas estas aplicaciones, especialmente por los casos en los que las actualizaciones incluyen parches a vulnerabilidades como las ya descritas.