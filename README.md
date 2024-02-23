# vita_wallet_api
###### API basica que permite consultar el precio del bitcoin (BTC) en tiempo real y generar transacciones de compra o venta de bitcoin en cualquier momento según el precio actual.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado lo siguiente en tu sistema:

- Ruby (versión 3.0.4)
- Rails (versión 7.0.8)
- PostgreSQL

## Instalación

Sigue estos pasos para configurar y ejecutar la aplicación localmente:

1. Clona este repositorio en tu máquina local:

```bash
git clone https://github.com/NachoAlia/vita_wallet_api.git
```
2. Accede al directorio de la aplicación:

```bash
cd vita_wallet_api
```

3. Instalacion de gemas necesarias:
```bash
bundle install
```
4. Configuracion de base de datos:
```bash
- cat database_example.yml

default: &default
  adapter: postgresql
  encoding: unicode
  host: your host
  username: your username
  password: your password
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>

development:
  <<: *default
  database: vita_waller_api_development

test:
  <<: *default
  database: vita_waller_api_test

production:
  <<: *default
  database: vita_waller_api_production
  username: vita_waller_api
  password: <%= ENV["VITA_WALLER_API_DATABASE_PASSWORD"] %>
```
4.1. Guardar el archivo como database.yml
4.2. Crear base de datos y ejecutar migraciones:
```bash
rails db:create
rails db:migrate
```
5. Para ejecutar la aplicación en tu máquina local, simplemente ejecuta el siguiente comando:
```bash
rails s
```

## Endpoints de la API
#### Esta sección describe los endpoints disponibles en la API de nuestra aplicación.

## Autenticación

### Iniciar Sesión

- **URL**: `/api/v1/login`
- **Método**: `POST`
- **Parámetros del cuerpo**:
  - `email`: Email del usuario (cadena)
  - `password`: Contraseña del usuario (cadena)
- **Respuesta Exitosa**:
  - Código de Estado: `200`
  - Cuerpo de Respuesta: Detalles del usuario (JSON), Token de acceso (cadena)
- **Respuesta de Error**:
  - Código de Estado: `401`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Cerrar Sesión

- **URL**: `/api/v1/logout`
- **Método**: `POST`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros del cuerpo**:
  - Ninguno
- **Respuesta Exitosa**:
  - Código de Estado: `204`
  - Cuerpo de Respuesta: Ninguno
- **Respuesta de Error**:
  - Código de Estado: `422`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Usuarios

### Crear Usuario

- **URL**: `/api/v1/users`
- **Método**: `POST`
- **Parámetros del cuerpo**:
  - `email`: Email del usuario (cadena)
  - `password`: Contraseña del usuario (cadena)
  - `password_confirmation`: Confirmación de la contraseña (cadena)
- **Respuesta Exitosa**:
  - Código de Estado: `201`
  - Cuerpo de Respuesta: Detalles del usuario creado (JSON)
- **Respuesta de Error**:
  - Código de Estado: `422`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Depósito

- **URL**: `/api/v1/deposit`
- **Método**: `POST`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros del cuerpo**:
  - `amount`: Cantidad a depositar (número)
- **Respuesta Exitosa**:
  - Código de Estado: `201`
  - Cuerpo de Respuesta: JSON con detalles del depósito creado
- **Respuesta de Error**:
  - Código de Estado: `422`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Transaccion de compra

- **URL**: `/api/v1/purchase`
- **Método**: `POST`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros del cuerpo**:
  - `currency_from`: Moneda de origen (cadena)
  - `currency_to`: Moneda de destino (cadena)
  - `amount`: Cantidad a comprar (número)
- **Respuesta Exitosa**:
  - Código de Estado: `201`
  - Cuerpo de Respuesta: Transacción creada (JSON)
- **Respuesta de Error**:
  - Código de Estado: `422`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Transaccion de venta

- **URL**: `/api/v1/sale`
- **Método**: `POST`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros del cuerpo**:
  - `currency_from`: Moneda de origen (cadena)
  - `currency_to`: Moneda de destino (cadena)
  - `amount`: Cantidad a vender (número)
- **Respuesta Exitosa**:
  - Código de Estado: `201`
  - Cuerpo de Respuesta: Transacción creada (JSON)
- **Respuesta de Error**:
  - Código de Estado: `422`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Detalles de Transacción

- **URL**: `/api/transactions/:id`
- **Método**: `GET`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros de Ruta**:
  - `id`: ID de la transacción (número)
- **Respuesta Exitosa**:
  - Código de Estado: `200 (OK)`
  - Cuerpo de Respuesta: Detalles de la transacción (JSON)
- **Respuesta de Error**:
  - Código de Estado: `404 (Not Found)`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Listado de Transacciones de un Usuario

- **URL**: `/api/v1/users/:user_id/transactions`
- **Método**: `GET`
- **Encabezados**:
  - `Authorization`: Bearer [token]
- **Parámetros de Ruta**:
  - `user_id`: ID del usuario (número)
- **Parámetros del cuerpo**:
  - Ninguno
- **Respuesta Exitosa**:
  - Código de Estado: `200 (OK)`
  - Cuerpo de Respuesta: Listado de transacciones del usuario (JSON)
- **Respuesta de Error**:
  - Código de Estado: `404 (Not Found)`
  - Cuerpo de Respuesta: Mensaje de error (cadena)

## Precio de Bitcoin (BTC)

- **URL**: `/api/v1`
- **Método**: `GET`
- **Encabezados**:
  - Ninguno
- **Parámetros del cuerpo**:
  - Ninguno
- **Respuesta Exitosa**:
  - Código de Estado: `200 (OK)`
  - Cuerpo de Respuesta: Precio actual de Bitcoin (JSON)

## Contribución

Si deseas contribuir a este proyecto, sigue estos pasos:

1. Haz un fork del repositorio.
2. Crea una nueva rama (`git checkout -b feature/nueva-caracteristica`).
3. Realiza tus cambios y haz commit de ellos (`git commit -am 'Agrega nueva característica'`).
4. Sube tus cambios a tu fork (`git push origin feature/nueva-caracteristica`).
5. Crea un nuevo Pull Request en este repositorio.

## Contacto

Si tienes alguna pregunta, sugerencia o comentario, no dudes en ponerte en contacto conmigo a través de:
- LinkedIn: [Nacho Alianiello](https://www.linkedin.com/in/nachoalia)
