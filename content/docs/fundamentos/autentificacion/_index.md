---
weight: 3
title: Autentificación y sus tipos
params:
  bookCollapseSection: true
---
{{< katex />}}

# Autentificación y sus tipos

> [!TIP]
> Cuando hablas por voz a un/una amigo/a, ¿Cómo sabes que la persona al otro lado del dispositivo es quien esperas que sea?
>

## Identificación

Identificación es el proceso por el que indico a otras entidades (de forma activa o pasiva) quién soy.

* **Si debo identificarme en persona**: 
  * Si me conocen, Otros me identifican por como me veo.
  * Si no me conocen, se espera que me presente. Es posible que esas personas asocien mi primera presentación con cómo hablo y me veo, para reconocerme en otras interacciones.
* **Si debo identificarme de forma remota, por texto**:
  * Si me conocen, me identifican porque les hablo desde un número que saben que es mío.
    > _...hasta que un amigo o amiga cae en una estafa de Whatsapp, le roban el teléfono y empieza a pedirnos cosas extrañas. Si les ha pasado, probablemente vivieron las semanas posteriores a ese evento un poco mas desconfiados o desconfiadas._
  * Si no me conocen, debo presentarme en la primera interacción.
* **Si debo identificarme de forma remota, por video o voz**:
  * Si me conocen, me identifican porque uso un usuario que he usado previamente, porque la voz que escuchan se parece a mi voz o porque la persona en el video se parece mucho a mi.
  * Si no me conocen (igual que presencialmente), se espera que me presente. Es posible que esas personas asocien mi primera presentación con cómo hablo y me veo, para reconocerme en otras interacciones.
    > [!COMMENT]
    > _...igual, con todo esto de la IA Generativa, se nos dice seguido que debemos desconfiar un poco más en estas situaciones._



Pero, en situaciones donde es realista pensar que un/a adversario/a puede tener el interés de hacerse pasar por otra entidad sin serlo, ¿cómo puedo saber que la entidad es quién dice ser? 


## Autentificación

En este curso, entenderemos autentificación o autenticación (en serio, [¡ambas son válidas!](https://dle.rae.es/autentificaci%C3%B3n)) como **el proceso que permite determinar que una entidad es lo que dice ser**.

Dependiendo del canal de comunicación, de qué tan seguro se quiere estar de que sea lo que dice ser y de si las entidades que quieren autenticarse se han visto previamente, existen muchas formas de hacerlo. En la tabla siguiente hay algunos ejemplos para situaciones informales (salidas con amigos, conversaciones de pasillo) y situaciones formales (entrar a un concierto u oficina, ingresar a una plataforma)

|     Cómo me autentico...       | En persona | Remotamente, solo texto (chat/sitio web) | Remotamente, audio y/o video |
|---------------------------------|------------|-------------------------|------------------------------|
| **Primera interacción**            | **Situación informal**: Un amigo en común nos presenta o me parezco a una foto en algún repositorio confiable. <br> **Situación formal**: Muestro mi cédula de identidad, validan que sea real y comparan la foto con la mía.   |   **Situación informal**: Referencias de otras personas o plataformas (usar un correo o teléfono declarado realista). <br> **Situación formal**: Creo una cuenta usando un identificador previamente reconocido o validado (teléfono, correo, usuario)  | **Situación informal**: Referencias de otras personas o plataformas (si mi foto está en algún lado oficial, se puede comparar con mi apariencia en video). <br> **Situación formal**: Identificadores comunes ya validados e intentos de reconocimiento de documentos por canales remotos (validación de cédula, reconocimiento facial, etc). |
| **Segunda interacción en adelante** | **Situación informal**: Me parezco a quien recuerdan que soy o cuento algo que solo yo podría saber. <br> **Situación formal**: Muestro una credencial que me dieron después de la primera validación de identidad.  |   **Situación informal**: Mantengo las mismas características de la primera vez (mi forma de escribir o cuento algo que solo yo debería saber). <br> **Situación formal**: Uso la cuenta creada después de la primera interacción que ya fue validada. | **Situación informal**: Mantengo parte de mi apariencia lo más parecida posible a interacciones anteriores (cómo me veo o como sueno, cómo me muevo, qué tan real se ve el video). <br> **Situación formal**: Uso la cuenta creada después de la primera interacción que ya fue validada.                             |


Lo curioso es que, al menos en los casos remotos, **casi siempre la autentificación es delegada a una autentificación previamente relalizada**. Es un problema bastante difícil de resolver por si solo, y es poco eficiente que cada entidad con la que debes autenticarte deba realizar el proceso completo.

> [!TIP]
> Piensa en situaciones en las que recuerdes que has tenido que autenticarte:
> * ¿Cómo lo has hecho?
> * ¿Crees que lo que te pidieron era sufiiciente para el modelo de amenazas que supones que debería haber tenido la situación?

## Autorización

La autorización incluye los procesos que determinan qué puede hacer una entidad específica. Si la autenticación es iniciar sesión en un sitio web, la autorización son los controles de permisos de acceso, ejecución de acciones y sus asignaciones a personas o grupos definidos. Veremos casos específicos con más detalle en las unidades _web_ y _seguridad de sistemas operativos_. Lo importante en este momento es que sepan que **Autentificación no es lo mismo que Autorización**

## Tipos de Autentificación y Autenticación Multifactor

La autentificación en contextos de sistemas de la información depende de **mecanismos** que la habilitan y que permiten confirmar (con un nivel de confianza específico y dependiente del modelo de amenazas) que soy quien digo ser.

Estos mecanismos se clasifican en tres tipos:
 * **Lo que sé**, a partir de información que solo yo debería conocer y memorizar o guardar en algún lado.
   > [!COMMENT]
   > _...lo malo es que son copiables, compartibles o filtrables 🫠..._
 * **Lo que tengo**, a partir de objetos que tengo en mi poder (y nadie más puede tener mientras yo lo tenga).
   > [!COMMENT]
   > _...si los pierdo es un cacho recuperarlos y necesito algún medio para bloquearlos..._


Cuando un sistema usa más de un tipo de los mecanismos anteriores, **y estos mecanismos no dependen entre sí**, estamos hablando de sistemas con **Autenticación Multifactor** (_MFA_ por sus siglas en inglés o _2FA_ cuando son solo dos mecanismos los usados)

> [!TIP]
> **¿Qué significa que los mecanismos no dependan entre sí?**: Que a partir de uno, no pueda derivar otro. Por ejemplo, si tengo una cuenta que para iniciar sesión me pide contraseña y para ejecutar acciones críticas me envía un código de un solo uso al correo o teléfono, pero puedo reiniciar ese último mecanismo contando solo con la contraseña, éste **no es un sistema con un mecanismo autentificación multifactor válido**.