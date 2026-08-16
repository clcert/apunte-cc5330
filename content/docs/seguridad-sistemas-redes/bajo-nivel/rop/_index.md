---
weight: 3
title: Return Oriented Programming
---

# Return Oriented Programming

En esta sección, veremos una versión especial de _buffer overflow_ que se aprovecha de código que podría estar presente desde antes (incluso sin que quienes programaron aplicación lo sepan), denominada _Return Oriented Programming_ o _ROP_ (juego de palabras frente al concepto _OOP_ o _Object Oriented Programming_).

En _ROP_, el objetivo es preparar el stack de tal forma que se apilen punteros a varias secciones del código terminadas en `return`. Como un `return` en condiciones normales cambia el valor del `eip/rip` por el último elemento de la pila (la que debería estar vacía en este frame), si lo hacemos con una pila modificada estaremos _encadenando colas de funciones_ para armar una nueva función con lo que requiramos.

Existe un caso específico de _ROP_ llamado _return-to-libc_ (o _ret2libc_), el cual utiliza la librería dinámica _libc_ para obtener _gadgets_ en vez de código estáticamente definido en el ejecutable. Además de eso, el método de explotación es el mismo.

Esta forma de ejecutar código arbitrario puede ayudar a superar medidas de mitigación frente a _Buffer Overflow_ como, por ejemplo, el definir secciones de la memoria no ejecutables para evitar la inyección de código arbitraria. Con _ROP_, no es necesario escribir código nuevo; basta con encontrar las _colas de funciones_ adecuadas para el fin buscado.

## Gadgets

Entenderemos como _gadgets_ a porciones de código de máquina terminadas en un `ret` o `return `. Esto nos limita a usar solo código que **termine con `return`**, dado que es la única forma que tenemos de limitar la ejecución hasta un punto determinado. Si quisiéramos seleccionar código que no termina en `return` como un _gadget_, ejecutaremos sin poder evitarlo las instrucciones que aparecen después de la línea final que seleccionamos (ya que no tenemos cómo controlar el flujo en esa parte).

En cambio, cuando el código seleccionado sí termina en `return`, podemos asegurarnos de que no se ejecutará nada distinto a lo que seleccionamos, al menos en ese frame específico.

> [!IMPORTANT]
> 👷 **Pendiente**: Un gráfico mostrando el comportamiento de los gadgets ROP.

## Cadenas ROP

Es muy poco probable que solo un _gadget_ sea suficiente para armar un exploit. Es por esto que se hace necesario _encadenar gadgets_ para que estos tengan el efecto deseado. Un conjunto de gadgets que ejecutan código útil para el objetivo del atacante es una _cadena ROP_ o _ROP Chain_.

Una _cadena ROP_ es un conjunto de direcciones de memoria que apuntan a los _gadgets ROP_ específicos. Como cada gadget _ROP_ finaliza con un `return`, si colocamos la secuencia de direcciones de memoria en el orden adecuado, podemos forzar a que el programa ejecute cada gadget ROP en el orden que necesitamos. Así, terminamos creando algo muy parecido a _shellcode_ sin necesidad de ejecutar código almacenado en la porción de datos de la memoria.

Las _cadenas ROP_ más comunes son las que permiten al atacante cambiar el proceso actual por una shell interactiva, o ejecutar código arbitrario como el usuario que ejecutó la aplicación vulnerable. 

> [!IMPORTANT]
> 👷 **Pendiente**: Un gráfico mostrando el comportamiento de las cadenas ROP.

## Cómo armar una cadena ROP

Existen aplicaciones que facilitan encontrar _gadgets_ y _cadenas ROP_, si se cuenta con el binario que está intentando ser explotado:

* [**ROPGadget**](https://github.com/JonathanSalwan/ROPgadget): Permite buscar _gadgets_ en los binarios para facilitar explotación ROP.
* [**Ropper**](https://github.com/sashs/Ropper) Muestra información de archivos en difrerntes formatos y encuentra _gadgets_ para construir _ROP Chains_ para diferentes arquitecturas.
* [**PwnTools**](https://docs.pwntools.com/en/stable/rop/rop.html): Módulo de Python con muchas herramientas para resolver problemas de CTF (entre ellos, ROP para _pwning_). 

Una vez que se arma una cadena ROP, se puede exportar como código de máquina para ser usada como entrada en un programa vulnerable.

> [!IMPORTANT]
> 👷 **Pendiente**: Agregar un ejemplo de armado de cadenas ROP con las librerías mostradas.


## Otras referencias

* [ROP en _HackTricks_](https://hacktricks.wiki/en/binary-exploitation/rop-return-oriented-programing/index.html#stack-alignment)