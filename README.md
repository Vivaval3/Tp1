# Sistema de Gestión de Alumnos - EPNro1 

Este proyecto consiste en un sistema de automatización en **Bash Shell** diseñado para procesar archivos de alumnos en segundo plano. El sistema monitorea una carpeta de entrada, consolida los datos en un archivo central y permite realizar consultas ordenadas.

## Características

* **Procesamiento en Segundo Plano:** Un script dedicado (`consolidar.sh`) monitorea la llegada de nuevos archivos.
* **Gestión de Duplicados:** Utiliza limpieza automática para evitar registros idénticos.
* **Consultas Inteligentes:** Ordenamiento por padrón, ranking de notas y búsqueda específica.
* **Arquitectura Auto-generada:** El menú principal se encarga de construir el entorno y los scripts necesarios.

## Estructura del Entorno

Al ejecutar la opción de "Crear Entorno", el sistema genera la siguiente estructura en `$HOME/EPNro1`:

* `/entrada`: Carpeta donde se depositan los archivos `.txt` nuevos.
* `/procesado`: Histórico de archivos ya integrados al sistema.
* `/salida`: Ubicación del archivo maestro consolidado.
* `consolidar.sh`: Script ejecutable que realiza la lógica de fondo.

## Instalación y Uso

1. **Clonar el repositorio o descargar el script:**
   ```bash
   git clone (https://github.com/Vivaval3/Tp1.git)
   cd Tp1
2. **Iniciar el programa:**

    `./menu.sh`
3. **Limpieza del Entorno:**
    Si deseas borrar todas las carpetas y detener los procesos, ejecuta:
    
    `./menu.sh -d`

## Formato de los Datos
El sistema espera archivos .txt con columnas separadas por espacios:  
`Padrón Nombre Apellido Email Nota`.

Ejemplo:  
`122332 Juan Lopez jlopez@fi.uba.ar 8`.

## Detalles Técnicos
**Prevención de Colisiones:** El script utiliza `pgrep` para asegurar que solo exista una instancia del proceso de consolidación corriendo a la vez.

**Optimización de Recursos:** El proceso de fondo duerme (`sleep`) y solo actúa si detecta archivos nuevos mediante un sistema de banderas (`flag`).

**Integridad de Datos:** Se utiliza `sort -u` con redirección segura para mantener el archivo maestro limpio y ordenado.
