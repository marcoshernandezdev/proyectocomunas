# Proyecto Comunas de Chile

Solución desarrollada en **.NET 8 o superior** para consultar las regiones y comunas de Chile y actualizar la información de una comuna. La aplicación utiliza una API REST, una interfaz web MVC y una biblioteca de acceso a datos con Entity Framework Core.

## Arquitectura de la solución

La solución está compuesta por tres proyectos:

- **ProyectoComunas.Datos**: biblioteca de clases responsable del modelo de datos, la configuración de Entity Framework Core y la ejecución de procedimientos almacenados.
- **ProyectoComunas.API**: Minimal API que expone las operaciones de regiones y comunas en formato JSON.
- **ProyectoComunas.Web**: aplicación ASP.NET Core MVC con Razor Views que consume exclusivamente los servicios publicados por la API.

El acceso a SQL Server se realiza mediante procedimientos almacenados. La actualización de una comuna se procesa en la base de datos mediante una sentencia `MERGE`.

## Tecnologías

- .NET 8 o superior
- ASP.NET Core Minimal API
- ASP.NET Core MVC y Razor Views
- Entity Framework Core 8
- SQL Server LocalDB
- Procedimientos almacenados y `MERGE`
- Swagger/OpenAPI
- Bootstrap

## Requisitos

- Visual Studio 2022 con la carga de trabajo **Desarrollo de ASP.NET y web**.
- SDK de .NET 8.
- SQL Server Express LocalDB o una instancia compatible con SQL Server 2012 o superior.
- SQL Server Management Studio es opcional, pero recomendado para ejecutar y verificar los scripts.

## Preparación de la base de datos

La instancia configurada por defecto es:

```text
(localdb)\MSSQLLocalDB
```

Desde SQL Server Management Studio, Azure Data Studio o `sqlcmd`, ejecutar los archivos de la carpeta `T-SQL` en el siguiente orden:

1. `T-SQL/00-BaseDeDatos/001-CrearBdd.sql`
2. `T-SQL/01-Table/011-crearTablas.sql`
3. `T-SQL/02-PoblarT/021-Poblar_region_comunas.sql`
4. Los archivos de `T-SQL/03-SP`, desde `031` hasta `035`.

Los scripts crean la base de datos `ProyectoComunas`, las tablas `Region` y `Comuna`, los datos iniciales y los siguientes procedimientos almacenados:

- `pc_Region_ObtenerTodos`
- `pc_Region_ObtenerPorId`
- `pc_Comuna_ObtenerPorRegion`
- `pc_Comuna_ObtenerPorId`
- `pc_Comuna_Guardar`

La columna `InformacionAdicional` utiliza el tipo `XML` de SQL Server.

El formato utilizado para la información adicional es:

```xml
<Info>
  <Superficie>4799.4</Superficie>
  <Poblacion Densidad="51.6">247552</Poblacion>
</Info>
```

## Configuración

La cadena de conexión y los nombres de los procedimientos almacenados se encuentran en `ProyectoComunas.API/appsettings.json`:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\MSSQLLocalDB;Database=ProyectoComunas;Trusted_Connection=True;TrustServerCertificate=True"
  }
}
```

La aplicación Web obtiene la dirección de la API desde `ProyectoComunas.Web/appsettings.json`. La URL debe coincidir con el perfil utilizado para iniciar la API:

```json
{
  "ApiSettings": {
    "BaseUrl": "http://localhost:5072"
  }
}
```

## Ejecución

1. Abrir `ProyectoComunas.sln` en Visual Studio 2022.
2. Restaurar los paquetes NuGet.
3. Verificar que la instancia LocalDB esté iniciada:

   ```powershell
   sqllocaldb start MSSQLLocalDB
   ```

4. Ejecutar los scripts SQL en el orden indicado.
5. Configurar como proyectos de inicio múltiple:
   - `ProyectoComunas.API`
   - `ProyectoComunas.Web`
6. Iniciar ambos proyectos.

Con los perfiles HTTP incluidos, las direcciones predeterminadas son:

- API y Swagger: `http://localhost:5072/swagger`
- Aplicación Web: `http://localhost:5268`

## Endpoints principales

| Método | Ruta | Descripción |
| --- | --- | --- |
| `GET` | `/api/region` | Obtiene todas las regiones. |
| `GET` | `/api/region/{idRegion}` | Obtiene una región por su identificador. |
| `GET` | `/api/region/{idRegion}/comuna` | Obtiene las comunas de una región. |
| `GET` | `/api/region/{idRegion}/comuna/{idComuna}` | Obtiene una comuna determinada. |
| `POST` | `/api/region/{idRegion}/comuna` | Actualiza una comuna mediante el procedimiento almacenado con `MERGE`. |

Las respuestas de la API se entregan en formato JSON y utilizan códigos HTTP para informar el resultado de cada operación.

## Pruebas con Swagger

Swagger permite revisar y ejecutar los endpoints desde el navegador y comprobar las respuestas JSON y los códigos HTTP.

### Capturas

#### Endpoints disponibles

![Endpoints disponibles en Swagger](docs/img/swagger-endpoints.png)

#### Consulta de regiones

![Resultado del endpoint de regiones](docs/img/swagger-regiones.png)

## Nota sobre la versión de SQL Server

La solución y los scripts SQL se han validado y están orientados a Microsoft SQL Server 2019. En concreto se está utilizando la versión:
