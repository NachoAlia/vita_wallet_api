# vita_wallet_api

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

