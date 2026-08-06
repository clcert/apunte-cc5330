---
weight: 1
params:
  bookFlatSection: true
title: 📚 Fundamentos de Ciberseguridad
---

# Fundamentos de Ciberseguridad

El siguiente es un punteo (un poco menos desordenado que la versión en vivo) de lo que vemos en las primeras dos clases.


## Lo administrativo

Cosas que mencionamos en clases sobre el curso y que no aparecen explícitamente en otras secciones del apunte (o que sí aparecen, pero vale la pena repetir).

### El Curso

El objetivo de este curso es enseñarles a pensar como un atacante o adversario (alguien que quiere ). Para lograr lo anterior, van a aprender cómo deberían funcionar los sitemas informáticos y cómo funcionan en la realidad, notando que, generalmente, ambos casos son muy distintos.

El curso está en un periodo de transición. Muy pronto será parte de la malla de la carrera, por lo que estamos intentando formalizar muchas cosas ya definidas en el programa (fundamentalmente evaluaciones, bibliografía y reglas de evaluación).

El contenido que veremos debería servirles sin importar si quieren o no dedicarse a ciberseguridad, ayudándoles a ser mejores personas desarrolladoras, jefas de proyecto, cientistas de datos o investigadoras. Pero, si les llama la atención el área, les entregaremos punteros para que ustedes puedan profundizar (por su cuenta o, en el futuro, tomando nuevos electivos) en estos contenidos.

### Formato de clases y evaluaciones

* Como dicen las [Reglas](/reglas), **las clases son completamente opcionales**. Las aprovecharemos para hablar de casos reales y conocidos en los que ocurrieron las vulnerabilidades o debilidades que describimos en el apunte, pero uno podría pasar el curso yendo solo a las auxiliares y leyendo el apunte (esperamos de todos modos que le encuentren valor a las clases y vayan, si pueden).
* Las auxiliares con evaluaciones (revisar el [Calendario](/calendario) para saber cuándo son) usarán un **bloque extendido** (de 10:00 a 12:00). Intentaremos terminar antes de las 12, pero reserven el tiempo por si acaso. Las auxiliares sin evaluaciones durarán el bloque normal y puede ser recomendable ir para preparar las evaluaciones.
* Los lenguajes de programación que usaremos son Python y C.

### Calendarización

* La calendarización presente en [Calendario](/calendario) presenta varias unidades, cada una de ellas se enfoca en tecnologías distintas. Para cada tecnología, veremos implementaciones comunes y vulnerabilidades originadas de esas implementaciones, así como también los resguardos 
* Si en un momento sienten que el curso se repite un poco, es un buen signo: Muchas vulnerabilidades en tecnologías distintas se parecen y originan de la misma causa raíz: (Ejemplo/ejercicio: inyecciones SQL, ejecución de código remoto, XSS e inyecciones de prompt. ¿en qué se parecen?)
* Si sienten que la cantidad de contenido en la calendarización es mucha, no se preocupen. El objetivo del curso es ser amplio en contenidos, pero poco profundo. Esperamos que el apunte y sus referencias les sirvan durante el curso y también en el futuro.

## Definiciones varias

Usaremos estas definiciones por ahora. Las mejoraremos a medida vayamos adentrándonos en la materia.

> [!INFO]
> **Discusión**: Cuando veas este recuadro, trata de contestar por tu cuenta la pregunta dentro de él.


### Hacking ético (y del otro)

La palabra _hacker_ es antigua y no significa necesariamente algo malo. En contexto computacional, la usaremos para definir a alguien muy entusiasta de la computación, que quiere entender cómo funcionan las cosas y encontrarles usos jamás imaginados por quienes las crearon. Lo anterior lo hace en parte porque cree que los sistemas deben estar al servicio de las personas que los utilizan (en contraposición a quienes los crearon), y en parte para volverse más experto en ellos que quienes los crearon (ya sea por desafío personal o por competitividad). Siéntanse libres de considerarse _hackers_ si se identifican con la definición.

> Una película que me gusta mucho del mundo hacker es [_WarGames (1983)_](https://www.rottentomatoes.com/m/wargames). Si les gustan las películas de los años 80 y no la han visto, se las recomiendo.
> 
> Trata de un estudiante secundario muy _hacker_ (según la definición de más arriba), que aprende a ingresar a sistemas ajenos para (por ejemplo) poder jugar juegos antes de que sean publicados.
> 
> Más allá de la trama, lo interesante del protagonista es que, al menos al inicio de la película, no parece ser ni _bueno_ ni _malo_. Tiene un solo objetivo: _jugar juegos antes de que sean publicados_. Y para lograrlo, se aprovecha de sus conocimientos y su tiempo libre para meterse donde no debería estar, sintiendo (seguramente) satisfacción por lograr algo que no cualquiera puede lograr y aprendiendo por su cuenta cosas que probablemente no le sirven de mucho en la escuela. Lo anterior, solo gracias a su comprensión mucho mayor a la media de cómo funcionan los sistemas informáticos, más allá de cómo fueron diseñados para funcionar. 

El título _Hacker ético_ se usa para designar a profesionales que "atacan" sistemas con permiso y reportan sus fallas a quienes lo fabrican para que sean parchadas, evitando que alguien más se hubiese aprovechado de ellas si las hubiese descubierto antes.

Saber cómo atacar no debe ser de por sí algo malo. Lo veremos con más detalle en la sección de "Principios de Ciberseguridad".

Los ciberdelincuentes (o _crackers_ o _sombrero negro_) vulneran sistemas sin permiso y afectan la confidencialidad, disponibilidad e integridad de los mismos. Puede ser por fama o por motivos activistas, económicos, de espionaje (entre países, entre empresas, entre personas), entre otros. (lo veremos con más detalle en la unidad de modelamiento de amenazas).

### Cómo funcionan las cosas y cómo deberían funcionar

Los sistemas que discutiremos y que están en producción, en general, son revisados con respecto a que hagan o no **las cosas que tienen que hacer**. Lo que no se revisa siempre es si hacen o no **lo que no tienen que hacer**. En la falta de revisión de esta última categoría se originan las **vulnerabilidades** (las definiremos con detalle en la sección de ese nombre, pero por ahora, quedémonos con esto).

> [!INFO]
> **Discusión**: ¿Qué debe hacer un sistema de pago en línea? ¿Qué no debe hacer un sistema de pago en línea?

Desde el punto de vista de ciberseguridad, hablamos al menos de cinco propiedades que queremos cuidar en un sistema. En palabras simples, son:
  * **Confidencialidad**: Que solo puedan acceder a información quienes tienen derecho a accederla.
  * **Integridad**: Que la información solo pueda ser modificada por quien tiene derecho a modificarla (y notar cuando no es así).
  * **Disponibilidad**: Que nadie pueda evitar el acceso a un sistema, en las condiciones especificadas, a quien tiene derecho a accederlo.
  * **Autenticidad**: Que podamos comprobar que la información proviene de quien dice venir
  * **No repudio**: Que si logramos comprobar que la información viene de alguien, no exista posibilidad de que no venga de esa entidad.

> [!INFO]
> **Discusión**: Para cada uno de los casos anteriores, piensa en sistemas que deberían considerar especialmente esa propiedad. ¿Por qué deberían considerarla?

>[!SUCCESS]
> **Lectura complementaria**: ¿Cómo me aseguro qué es un sistema es seguro? ¿Basta con tener su código fuente y compilarlo por mi cuenta? ¿Y si no confío en el compilador o el intérprete? Revisa [Reflections on Trusting Trust](https://dl.acm.org/doi/epdf/10.1145/358198.358210) del ganador del premio Turing y co-creador de Unix [Ken Thompson](https://en.wikipedia.org/wiki/Ken_Thompson).