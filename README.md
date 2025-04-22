# Oracle Changelog Watcher

Este script Bash supervisa continuamente el archivo `CHANGELOG.md` del integration core de Oracle en el repositorio oficial de Datadog. Su objetivo es detectar actualizaciones en el archivo y registrar los cambios en un archivo de log local.

##  ¿Qué hace el script?

1. **Verifica la existencia local del `CHANGELOG.md`** en `/opt`.
2. Si no existe:
   - Lo descarga desde el repositorio de Datadog.
3. Si ya existe:
   - Descarga una copia temporal del changelog.
   - Compara los hashes MD5 del archivo actual y el temporal.
   - Si son diferentes:
     - Registra en `/opt/changelog_update.log` que hubo una actualización.
     - Sustituye el archivo antiguo por el nuevo.
   - Si son iguales:
     - Elimina la copia temporal.

4. **Este proceso se repite cada 2 minutos.**

##  Ruta del archivo monitoreado

- `CHANGELOG.md` se almacena en: `/opt/CHANGELOG.md`
- Las actualizaciones se registran en: `/opt/changelog_update.log`

##  Fuente oficial del changelog

- URL: [oracle/CHANGELOG.md en Datadog](https://raw.githubusercontent.com/DataDog/integrations-core/refs/heads/master/oracle/CHANGELOG.md)
