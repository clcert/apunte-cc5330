---
weight: 1
title: Lo que sé
---
{{< katex />}}


# Lo que sé

En esta categoría tenemos los siguientes mecanismos:
* **Contraseñas**: Cadenas de texto secretas usadas por un sistema para determinar si alguien es quien dice ser. **Deberían ser largas, a veces recordables y no fácilmente adivinables**
* **Número de identificación personal (PIN por su sigla en inglés)**: Cadena de texto corta y generalmente numérica para determinar si alguien es quien dice ser. **No debería representar una fecha importante**.

> [!WARNING]
> Algunas personas y empresas recomiendan cambiar contraseñas y pines seguido, pero esto hoy **no se recomienda, siempre y cuando no haya evidencia de que el dato pudo haber perdido su calidad de secreto**. El **CSIRT Nacional** [tiene un artículo muy interesante sobre este tema](https://csirt.gob.cl/articulo/obligar-a-cambiar-claves-cada-90-dias-es-mala-idea/).
>  > [!COMMENT]
>  > ...¿esto es autopromoción no explicitada? 🤔... 


## 🧢🧑‍💻: Cómo guardar contraseñas de forma segura

Si estamos desarrollando un sistema con inicio de sesión con contraseña, ¿cómo validamos seguramente ambos valores?

### Guardando la contraseña en texto plano 

| ID | Usuario | Contraseña |
|---|---|---|
| 1 | eriveros  | password |
| 2 | ahevia | c0ntr4s3ñ4 |
| 3 | cjgomez | #n2d9aAmVV9 |

Al momento de iniciar sesión, la aplicación consultará en la tabla si existe una fila con los valores nombre de usuario y contraseña proporcionados.

Si bien lo anterior sirve para validar acceso, presenta riesgos importantes debido al impacto que tendría si un adversario lograra tener acceso a esta tabla (recordemos **el principio de defensa en profundidad**).

> [!COMMENT]
> O si la persona que administra la tabla [decide venderla o compartirla](https://xkcd.com/792/)... _(El comic es del 2010 y envejeció mal con eso del "don't be evil"_ 🙄)

**¿Por qué esto es impactante?**: Porque **las personas suelen repetir sus contraseñas entre sitios** (o cuando no la repiten, usan una muy parecida; lo que también es preocupante, pero un poco menos).

### Guardando el _hash_ de la contraseña

| ID | Usuario | SHA256(Contraseña) |
|---|---|---|
| 1 | eriveros  | `5e884898da28047151d0e56f8dc6292773603d0d6aabbdd62a11ef721d1542d8` |
| 2 | ahevia | `f55cffba6274d372aeefafa64862e8bff89a8a157fc28cd61a352379e51ae18b` |
| 3 | cjgomez | `d7ad0a3d878d1aaaa66a4a015d1d16711307693bda03864fe1da80322b508450` |

Nos estamos adelantando un poco, porque no hemos visto _hashes_ todavía. Por ahora, supongan que un _hash_ es una función unidireccional que a cada cadena de texto arbitraria le asigna un número muy grande de tamaño fijo (por ejemplo, de 256 bits), aparentemente aleatorio.

Luego, para comprobar si la contraseña de un usuario es válida, basta con comparar el valor de la fila correspondiente en la columna "Contraseña" con $SHA256(entradaContrasena)$, donde $entradaContrasena$ es el valor ingresado por el usuario en el campo "contraseña" del formulario para iniciar sesión.

#### Funciones de hash rotas

Como veremos más adelante, una buena función de hash no debería ser reversible (es decir, dado un valor de _hash_, si no conozco el texto plano que lo originó, no debería poder deducirlo). Sin embargo, muchas funciones de hash estandarizadas sobre las que se creía que esta propiedad se cumplía, pero luego se demostró que no era tan así. 

Algunas funciones rotas: **MD5** y **SHA-1**. 

> [!WARNING]
> **Nunca debes usar MD5 ni SHA-1 para guardar contraseñas**.

Actualmente, existen varias funciones de hash que (todavía) no están rotas. `SHA-256` y `SHA-3` son ejemplos de ellas.

#### _Rainbow tables_

Una _Rainbow Table_ ("Tabla Arcoiris" suena extraño, pero puede que sea solo costumbre) es una base de datos en la que, para cada cadena de texto plano conocida, se genera la versión _hasehada_ de esa cadena y se guardan ambos datos asociados.

| Palabra | SHA256(Palabra) | 
|---|---|
| hola | `133ee989293f92736301280c6f14c89d521200c17dcdcecca30cd20705332d44`  |
| adios | `d8542114d7d40f3c82fc0919efc644df30f4e827c2bd6b83b9dbec8358b2fbc4` | 
| casa | `02a68f9d9195dd53eb799f866429ce06e93be4ddf8b1b41a3d926dcf7d4f535f` | 
| ... | ... | 

Así, si queremos encontrar la preimagen de un _hash_ específico, basta con buscarlo en la tabla.

Debido al tamaño del conjunto de las imágenes de la función, es actualmente imposible (y puede que siga siendo así por mucho mucho tiempo) almacenar todas las preimágenes posibles si la función de hash tiene un tamaño de cadena de texto en el recorrido razonable (como 256 bits).

> [!TIP]
> Si las preimágenes son todas de tamaño 256 bits, ¿cuántas posibles preimágenes existen? ¿Cuánto espacio necesitaría para guardarlas todas sin comprimirlas?

Pero no necesitamos guardarlas todas, basta con guardar las de las palabras que son usadas más comúnmente como contraseñas, junto con variaciones típicas de ellas. Estas palabras se pueden obtener de filtraciones en texto plano anteriores, o de _infostealers_ (los veremos más adelante en este capítulo).

De esta forma, si la contraseña se filtra en un solo lugar en texto plano (a cualquier persona, suponiendo que es una que podría tener alguien más) y alguien la almacena en una _rainbow table_, va a poder relacionarla con cualquier otro lugar donde esté. **Este ataque aplica tanto a hashes rotos como a hashes no rotos**.


> [!TIP]
> Busca los hashes de la tabla de usuarios al inicio de la sección. ¿Para cuáles encuentras el texto plano en Internet y para cuales no? (es posible que encuentres el texto plano de todos, si alguien ingresó sus preimágenes a una _rainbow table_ pública).

Hoy día, debido a lo eficientes que son los procesadores al ejecutar funciones de hash conocidas, es posible generar millones de hashes en menos de un segundo en un computador al alcance de casi cualquier persona. Esto hace que, incluso sin conocer la contraseña original, los ataques de fuerza bruta (discutidos más adelante) sigan siendo efectivos.


### Guardando un _hash especial_ de la contraseña

| ID | Usuario | PBKDF2(Contraseña) |
|---|---|---|
| 1 | eriveros  | `pbkdf2_sha256$600000$N9H3Y+UMFADQxAusfdB6TQ==$eQ2NP3cApLdIg/z9gDjtc5bAh1b1oeK0qZzoVYqL4bc=` |
| 2 | ahevia | `pbkdf2_sha256$600000$3ktDNrl6VHA9F+SFCe9I8Q==$GCaTg0JGdwrAdPOX6iRpBGKCYXU+Gzoc5hDmM659vEk=` |
| 3 | cjgomez | `pbkdf2_sha256$600000$3ktDNrl6VHA9F+SFCe9I8Q==$JzfDfyTxttB2p2Rwx6R9f/vmhQotMYMNxR+FfOl9CpM=` |

Existen hashes especiales llamados _Funciones de derivación de llaves_ (KDF por sus siglas en inglés) que guardan una _llave derivada_, la que es como un hash con parámetros adicionales. 

Para comprobar si la contraseña de un usuario es válida, basta con ejecutar una función integrada en las librerías de _KDF_: $validarContrasena(entradaContrasena, columnaContrasena)$, donde $entradaContrasena$ es el valor ingresado por el usuario y $columnaContrasena$ el valor guardado en la tabla. Esta función devolverá `verdadero` si la contraseña es correcta, y `falso` si no.

El campo $columnaContrasena$ posee cuatro valores distintos en el ejemplo, separados entre sí por el signo \$ (el formato puede variar un poco según implementación):
* **tipo de KDF**: Identifica el tipo de _hash_  que se está usando para generar la versión hasheada de la contraseña. Ene ste caso es la función ${PBKDF2}$ en su variación con ${SHA256}$.
* **Cantidad de iteraciones**: Número de veces que se aplica la función sobre sí misma. En el ejemplo, es 600.000.
* **Sal Criptogrtáfica o _salt_**: Valor aleatorio (codificado en `base64` en el ejemplo) que se usa para aleatorizar el resultado en la función _KDF_. Se guarda en texto plano como parte del campo contraseña para poder usarlo en la verificación.
* **Hash de contraseña**: Valor resultante de aplicar la función KDF especificada con el número de iteraciones y la sal criptográfica correspondiente.

Para validar una contraseña almacenada con una _KDF_, **es necesario contar con todos los valores de la lista anterior**.

Estas funciones poseen dos propiedades adicionales a los hashes tradicionales.

* **Son parametrizablemente lentas**: Los procesadores de hoy son muy eficientes calculando hashes tradicionales porque están optimizados para esto. Las funciones de tipo _KDF_ permiten parametrizar la cantidad de veces que la función de _hash_ debe aplicarse sobre si misma para llegar al valor final. De esta forma, es posible siempre aumentar la cantidad de iteraciones para demorar aún más el proceso de verificación.
* **la Sal Criptográfica (bien usada) imposibilita poder correlacionar filtraciones de contraseñas entre sí**: Si la sal criptográfica es aleatoria, incluso si la tabla con las _llaves derivadas_ KDF se filtra, no debería ser posible correlacionar las contraseñas de esta filtración con otras anteriores.

Lo anterior vuelve a las _KDF_ la mejor forma de guardar contraseñas en la actualidad.

## 🧢🧑: Cómo elegir buenas contraseñas para memorizar

Una buena contraseña que debe ser memorizada tiene que ser fácil de recordar y difícil de adivinar (ya sea por _fuerza bruta_ o por deducción).

El problema es que las personas tenemos muy mala memoria para datos aleatorios, pero no así para información estructurada o relacionable mediante historias.

Si estás obligado a memorizar una contraseña, lo más recomendable es usar frases de paso (_passprhases_), que son un conjunto de 4 o más palabras *aleatorias** de un diccionario lo suficientemente grande.

> [!warning]
> Si no son aleatorias, el **modelo de seguridad no funciona**. Asegúrate de que sean aleatorias, para lo que puedes usar dados o una página como la enlazada más adelante.


Una buena explicación de por qué una frase de paso puede ser más segura que una contraseña tradicional recordable está [en el comic 936 del web comic XKCD](https://xkcd.com/936/)

{{< image src="./password_strength.png" alt="Cómo crear buenas contraseñas con frases de paso" title="Cómo crear buenas contraseñas con frases de paso" loading="lazy" >}}


Puedes generar frases de paso en la aplicación [CiberLupa](https://ciberlupa.anci.gob.cl/generador/) de la **Agencia Nacional de Ciberseguridad**. 

> [!TIP]
> CiberLupa ofrece 6 palabras por defecto. ¿Cómo saber cuánta entropía es eso y si es suficiente para mi caso de uso?
> 
> **Pista**: ¿Cuántas palabras usa el sistema de Ciberlupa? ¿Cuánta entropía aporta cada palabra?

En la práctica, lo recomendable es anotar la palabra en un cuaderno u hoja que tengas en un lugar seguro y solo a tu alcance. Así, puedes ir viéndola cada vez que se te olvide hasta memorizarla por completo. Si temes olvidarla en el futuro, déjala guardada en una caja fuerte o escondida físicamente en algún lugar de donde vives (sin dejar escrito que es tu contraseña, en lo posible).


## 🧢🧑‍💻: Cómo dificultar ataques de fuerza bruta

Los ataques de fuerza bruta sobre contraseñas son cada vez más efectivos. Según [Hive Systems](https://www.hivesystems.com/blog/are-your-passwords-in-the-green), cada año es más fácil adivinar algunas contraseñas solo por fuerza bruta:

{{< image src="./crack_passwords.gif" alt="Tiempo que demora adivinar una contraseña por fuerza bruta" title="Tiempo que demora adivinar una contraseña por fuerza bruta" loading="lazy" >}}

> [!COMMENT]
> ¿ese uso de "hacker" es negativo?

Si bien una forma de hacerlos menos efectivos es usar las **funciones de derivación de contraseñas** vistas hace unas secciones (ya que así el tiempo de validación se puede hacer mucho más lento según los parámetros usados), hay otras estrategias útiles para ayudar a los usuarios de un sistema a no correr este riesgo:

* **Definir reglas de largo y caracteres mínimos**: Viendo la imagen anterior, para una cuenta que solo permite acceso a un servicio, 9 o 10 caracteres aleatorios alfanuméricos (mayúscula o minúscula) es una cantidad razonable. Estos caracteres deben ser aleatorios
* **Bloquear ingreso temporalmente después de un número de intentos fallidos**: Esto puede generar problemas de denegación de servicio a personas cuyas credenciales no están filtradas o que comparten recursos de red (como IP), pero ayuda a evitar el ingreso por contraseña adivinada. Algunas formas de implementarlo pueden ser bloquear unos minutos o horas si hay más de $n$ intentos fallidos sobre un usuario específico, o si los intentos vienen de una IP o subred específica.
* **Bloquear el uso de contraseñas que se sabe que están filtradas**: Existen servicios como [CiberLupa](https://ciberlupa.anci.gob.cl) o   [Have I Been Pwned?](https://haveibeenpwned.com/) que permiten saber si un usuario específico ha aparecido en una filtración de datos reconocida. _Have I Been Pwned?_ además provee un servicio para saber (sin un riesgo claro de exfiltrar la contraseña de uno al usar el servicio) si la contraseña de una persona ha sido vista en filtraciones de datos previas, lo que se puede integrar en formularios de registro y cambio de contraseña para imposibilitar su uso.

> [!COMMENT]
> CiberLupa fue creado por un estudiante del DCC (Nicolás Santibáñez) como parte de su memoria. Puedes encontrar su código fuente [en este enlace](https://github.com/hackerlab-uchile/leak-checker).

## 🧢🧑: Cómo tener mil contraseñas distintas y no morir en el intento

A estas alturas, ya queda súper claro que no es bueno tener contraseñas adivinables ni es bueno repetirlas entre sitios distintos. Esto nos deja en una situación super incómoda para un usuario: tener que usar valores distintos (incluso aleatorios) en cada sitio, los que puede que no sean adivinables, pero definitivamente no serán recordables.

> [!COMMENT]
> ¿Por qué los y las usuarias tienen que cambiar sus hábitos de uso de los computadores debido a desarrolladores que no implementan bien las cosas? 🙃

Una solución al problema anterior es el uso de **gestores de claves**. Un gestor de contraseñas almacena todos los usuarios y las contraseñas de una persona, etiquetándolas por URL de sitio, y actúa como una bóveda con una llave principal (que debe ser larga, muy recordable y para nada adivinable). La llave principal se usa para cifrar simétricamente el archivo que guarda todos los datos, por lo que, si este archivo se filtra, la seguridad de todos los sitios dependerá de la seguridad de la contraseña primaria.

Se recomienda fuertemente usar una **frase de paso** de 4 palabras aleatorias o más como contraseña primaria de un gestor de claves.

Existen muchos proveedores de gestores de contraseñas recomendables. A continuación compartimos algunos de ellos:

* **[KeepassXC](https://keepassxc.org/)** Gestor de claves gratuito y de código abierto basado en _Keepass_ que guarda las contraseñas cifradas con la contraseña principal en un archivo local `.kdbx`. Existen aplicaciones para escritorio y móviles que pueden abrir este archivo, y se puede mantener respaldado en línea usando servicios de nube conocidos, como iCloud y Google Drive.
* **[1Password](https://1password.com/)**: Gestor de claves comercial que guarda las contraseñas cifradas en un servicio hospedado por ellos. **Ellos no tienen acceso directo a las contraseñas**. La aplicación es muy amigable, pero su uso requiere de pago.
* **[Bitwarden](https://bitwarden.com/) (y [Vaultwarden](https://github.com/dani-garcia/vaultwarden))**: Gestor de claves comercial que guarda las contraseñas cifradas en un servicio hospedado por ellos, pero también cuentan con una [versión oficial autohospedable](https://github.com/bitwarden/server) y [otra no oficial](https://github.com/dani-garcia/vaultwarden) que es compatible con todas las aplicaciones de Bitwarden.

**No se recomienda usar gestores de contraseña integrados en los navegadores (como el de Google o el de Firefox)**, por motivos que se describirán en la sección _Infostealers_.

## ¿Con lo anterior es suficiente para solo usar contraseñas como método de autenticación?

Lamentablemente, **no**. Hay algunos problemas que siguen afectando de forma parcial o total al uso de contraseñas como único factor de autenticación. 

### Ataques de diccionario

Dado un conjunto de palabras que se conoce común en las contraseñas de las personas (generalmente determinado por filtraciones anteriores), es posible reducir el dominio de intentos de todo un alfabeto a una combinación de palabras comunes y sus variaciones. A esto le denominamos un **Ataque por diccionario** y **no** es lo que muestra [la primera imagen de la sección de humor del CLCERT](https://clcert.cl/humor/page/2/):

{{< image src="./dictionary-attack.jpg" alt="El primer comic de la sección de humor de clcert.cl. Una persona tirando un diccionario a otra y gritando dictionary attack!" title="El primer comic de la sección de humor de clcert.cl" loading="lazy" >}}

### Infostealers

Un infostealer es un tipo de _malware_ (veremos más de esto más adelante) que se instala en los computadores de los usuarios y **envía a un servidor controlado por un atacante todo tipo de información personal, como por ejemplo**:
 * Datos específicos del equipo (Sistema operativo, características de hardware, IP externa):
 * Documentos `.docx`, `.ppt`, `.xlsx`, `.pdf`
 * Tokens de acceso de aplicaciones instaladas en el escritorio (_Discord_, _Telegram_, _Notion_, etc.).
 * Llaves privadas de wallets de criptomonedas.
 * Historial, cookies, **contraseñas** y datos de autocompletado de navegadores.

Esta información es luego revisada y vendida por _actores de amenaza_ (esto también lo veremos más adelante) en paquetes o agrupada por recurso afectado (por ejemplo, archivos con miles de contraseñas de un mismo sitio).

Hoy en día, los _actores de amenaza_ que buscan ingresar a sitios específicos compran a otros _actores de amenaza_ esta información, para luego desplegar _ransomware_ o exfiltrar otro tipo de información valiosa.

---

## Conclusiones

Con lo que hemos aprendido hasta ahora, podemos desmitificar un poquito el cómo ocurren la mayoría de los ciberataques. [Este comic de XKCD](https://xkcd.com/2176/) lo explica bien:

{{< image src="./how_hacking_works_2x.png" alt="Cómo funcionan los ciberataques en general" title="Cómo funcionan los ciberataques en general" loading="lazy" >}}

> [!COMMENT]
> El comic de arriba es del 2019. Podríamos decir que hoy (2026) la fuente más probable es un feed de un infostealer.

Es por esto que usar solo una contraseña no es suficiente para el modelo de amenaza comúnmente reconocido en sistemas conectados a Internet. La mitigación más efectiva a este problema es usar más de un tipo de factor de autentificación, lo que nos lleva a describir los dos tipos restantes.