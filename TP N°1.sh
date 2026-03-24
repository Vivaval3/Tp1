#!/bin/bash

export FILENAME="FILENAME"
ENTORNO="$HOME/EPNro1"
SALIDA="$ENTORNO/salida/$FILENAME.txt"

#eliminamos el entorno creado y detenemos la ejecución en el background 
if [ "$1" == "-d" ]; then
  echo "Eliminando entorno y procesos..."
  rm -rf "$ENTORNO"
  pkill -f "consolidar.sh"
  echo "Entorno eliminado."
  exit 0
fi


while true; do
  echo "Menu:"
  echo "_______________________"
  echo "1.) Crear entorno"
  echo "2.) Correr proceso"
  echo "3.) Listar alumnos"
  echo "4.) Top 10 notas"
  echo "5.) Buscar por padrón"
  echo "6.) Salir"
  echo "______________________"

  read -p "Opción: " opcion

  case $opcion in
    1)
      mkdir -p "$ENTORNO/entrada" "$ENTORNO/salida" "$ENTORNO/procesado"
      cp ./consolidar.sh  $ENTORNO/consolidar.sh
      chmod +x "$ENTORNO/consolidar.sh"
      echo -e "\nEntorno creado\n"
      ;;
    2)
      "$ENTORNO/consolidar.sh" &
	echo ""
      echo "Proceso en ejecución..."
      ;;
    3)
      if [ -f "$SALIDA" ]; then
        echo -e "\n--- LISTADO POR PADRÓN ---"
        sort -k1,1n "$SALIDA"
      else
        echo "Archivo no creado aún."
      fi
      ;;
    4)
      if [ -f "$SALIDA" ]; then
        echo -e "\n--- TOP 10 NOTAS ---"
        sort -k5,5nr "$SALIDA" | head -n 10
      else
        echo -e "\nArchivo no creado aún."
      fi
      ;;
    5)
      if [ -f "$SALIDA" ]; then
	echo ""
        read -p "Ingrese el número de padrón: " padron
	echo -e "\nResultado de su busqueda:"
        grep -w "^$padron" "$SALIDA" || echo "Padrón no encontrado."
      else
        echo -e "\nArchivo no creado aún."
      fi
      ;;
    6)
      echo -e "\nSaliendo..."
      exit 0
      ;;
    *)
      echo ""
      echo "Opción inválida. Por favor seleccione una opción válida"
      ;;
  esac

  echo ""
done
