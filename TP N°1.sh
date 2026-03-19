#!/bin/bash

export FILENAME="FILENAME"

while true; do
  echo "----------------------"
  echo "1. Crear entorno"
  echo "2. Correr proceso"
  echo "3. Listar alumnos"
  echo "4. Top 10 notas"
  echo "5. Buscar por padrón"
  echo "6. Salir"
  echo "----------------------"

  read -p "Opción: " opcion

  case $opcion in
    1)
      mkdir -p "$HOME/EPNro1/entrada"
      mkdir -p "$HOME/EPNro1/salida"
      mkdir -p "$HOME/EPNro1/procesado"
      
      echo "Entorno creado."
      ;;
    2)
      "$HOME/EPNro1/consolidar.sh" &
      echo "Proceso en ejecución..."
      ;;
    3)
      if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
        sort -k1,1n "$HOME/EPNro1/salida/$FILENAME.txt"
      else
        echo "Archivo no creado aún."
      fi
      ;;
    4)
      if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
        sort -k5,5nr "$HOME/EPNro1/salida/$FILENAME.txt" | head -n 10
      else
        echo "Archivo no creado aún."
      fi
      ;;
    5)
      if [ -f "$HOME/EPNro1/salida/$FILENAME.txt" ]; then
        read -p "Ingrese el número de padrón: " padron
        grep "^$padron " "$HOME/EPNro1/salida/$FILENAME.txt"
      else
        echo "Archivo no creado aún."
      ;;
    6)
      echo "Saliendo..."
      break
      ;;
  esac

  echo ""
done
