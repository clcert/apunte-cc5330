---
weight: 1
title: Aplicaciones Web
---

# WWW y Aplicaciones web

Según [MDN](https://developer.mozilla.org/en-US/docs/Glossary/World_Wide_Web), la _World Wide Web es un sistema de páginas web públicas interconectadas y accesibles a través de la Internet.

## HTTP

### GET y POST

### ¿Cómo agregar estado a un protocolo sin estado?

### Tipos de contenido

#### HTML

#### APIs

* 🐞 **Cross Origin Resource Sharing**

## Tipos de aplicaciones web

### _Server Side Rendering_ y _CGIs_

### _Single Page Applications_

### _Back-to-front_ y otros modelos híbridos

> [!TIP]
> ¿Es una debilidad exponer todo el código del front a todos los usuarios o listar públicamente las APIs de una aplicación? Comenta pros y contras de esta medida en términos de lo que podría hacer un atacante con esta información.

## Ejecución de código del lado del cliente

### Javascript 

#### 🐞 _Cross Site Request Forgery_

#### 🐞 _Cross Site Scripting_

### WASM

## Bases de Datos

### 🐞 Inyecciones SQL

## Almacenamiento de archivos

### 🐞 Exposición de buckets

### 🐞 Subida de archivos ejecutables

## Otras vulnerabilidades y debilidades


### 🐞 Ejecución remota de código 
### 🐞 Validaciones solo en el código de cliente
### 🐞 Inclusión de archivos local o remota
### 🐞 _Insecure Direct Object References_ (IDORs) y enumeraciones
### 🐞 Ataques de Cadena de suministro
### 🐞 Malvertising
### 🐞 Exposición insegura de infraestructura


## Mitigaciones generales

* **Usar ORMs y frameworks reconocidos**:
* **Sanitizar entradas**:
* **Usar WAF de confianza**:
* **Usar _prepared statements_ al trabajar con bases de datos**:
* **No exponer infraestructura que no necesita ser expuesta**:
* **Usar bloqueadores de anuncios**:

