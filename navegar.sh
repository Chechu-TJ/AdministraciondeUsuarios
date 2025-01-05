#!/bin/bash

# Función para navegar por el sistema de archivos
navegar() {
  while true; do
  
  
    read -p "cd> " comando ruta

    if [ "$comando" = "cd" ]; then
      cd "$ruta" 2>/dev/null || echo "Directorio no encontrado."
    elif [ "$comando" = "ls" ]; then
      ls "$ruta" 2>/dev/null || ls
    elif [ "$comando" = "exit" ]; then
      break
    else
      echo "Comando no reconocido. Usa 'cd [ruta]', 'ls [ruta]' o 'exit' para salir."
    fi
  done
}

# Llamar a la función de navegación
echo -e "\n"
echo "Bienvenido a la navegación interactiva. Usa 'cd' para cambiar de directorio, 'ls' para listar contenido o 'exit' para salir."
echo -e "\n"
echo "Consejo: No funciona las opciones de autocompletado al utilizar la tecla 'tabulación'."
echo -e "\n"
echo "Cuando hayas encontrado el archivo u directorio, escribe 'exit' y te pedirá que introduzcas el nombre completo."
echo "Importante no salirse del directorio donde se encuentra el archivo o directorio."
navegar

# Después de navegar, pedir la dirección del archivo
while true; do
read -p "Introduce el nombre del archivo o del directorio: " ARCHIVO
if [ ! -e "$ARCHIVO" ];then
	echo "La ruta o el archivo no existe, prueba otra vez"
	else
	echo "La ruta del archivo o directorio es correcta"
	echo "$(pwd)/$ARCHIVO"
	echo -e "\n"
	break
	fi
done
# Obtener ruta completa
Ruta_completa="$(pwd)/$ARCHIVO"

# Exportar variable

export DIR_COMPLETA="$Ruta_completa"