# Bblin
# Documento README

Este es un script de Bash que te permite editar archivos de texto de una manera interactiva en la terminal. Proporciona varias funciones útiles, como buscar una cadena en el archivo, buscar y reemplazar una cadena, copiar una línea del archivo y pegarla en otra posición.

## Requisitos

- Linux o macOS
- Bash (Bourne Again SHell)
- Dialog (una utilidad de línea de comandos para crear interfaces de diálogo)

## Uso

El script se puede ejecutar de la siguiente manera:

```bash
./script.sh [archivo]
```

Si no se proporciona ningún archivo como argumento, se abrirá un "File chooser" para seleccionar el archivo que deseas editar.

Una vez que se haya seleccionado o proporcionado el archivo, se mostrará una interfaz de edición en la terminal. Puedes modificar el contenido del archivo y guardarlo. Si eliges no guardar los cambios, se mostrará un menú con las siguientes opciones:

1. **Buscar**: Busca una cadena en el archivo y muestra las coincidencias resaltadas.
2. **Buscar y reemplazar**: Busca una cadena en el archivo y la reemplaza por otra.
3. **Copiar línea**: Permite copiar una línea del archivo.
4. **Pegar línea**: Permite pegar la línea copiada en otra posición del archivo.
5. **Salir**: Finaliza el script sin guardar los cambios realizados.

## Limitaciones

- El script está diseñado para funcionar en entornos Linux o macOS con Bash y Dialog instalados. Puede que no funcione correctamente en otros sistemas operativos o si falta alguna de las dependencias requeridas.
- El script no admite la edición de archivos binarios o archivos protegidos contra escritura.
- El manejo de archivos grandes puede tener un rendimiento subóptimo debido a la carga completa del archivo en la memoria.
- Ten en cuenta que cualquier cambio realizado en el archivo será permanente y no se puede deshacer automáticamente.

## Contribuciones

Si deseas contribuir a este proyecto, siéntete libre de hacer fork del repositorio, implementar mejoras y enviar una solicitud de pull. También puedes informar cualquier problema o sugerencia en la sección de problemas del repositorio.

## Licencia

Este script se distribuye bajo la [Licencia Pública General GNU (GPL) versión 3.0](https://www.gnu.org/licenses/gpl-3.0.html).
