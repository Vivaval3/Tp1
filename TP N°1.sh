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
      echo "Entorno creado."
      ;;
    2)
      echo "Proceso en ejecución..."
      ;;
    3)
      echo "Mostrando alumnos..."
      ;;
    4)
      echo "Top 10 notas..."
      ;;
    5)
      echo "Buscando padrón..."
      ;;
    6)
      echo "Saliendo..."
      break
      ;;
  esac

  echo ""
done
