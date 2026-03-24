#!/bin/bash

if [ "$1" == "-d" ]; then
  echo "Eliminando entorno y matando procesos..."

#Matamos primero los procesos, para evitar posibles errores.
  pkill -f "consolidar.sh"
  rm -rf "$HOME/EPNro1"

  exit 0
fi

export FILENAME="FILENAME.txt"

while true; do
#Más compacto sin las (), más centrado que los __.
  echo "----------------------"
  echo "1. Crear entorno"
  echo "2. Crear proceso"
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

#Alternativa propuesta, menor dependencia.
      cat > "$HOME/EPNro1/consolidar.sh" << "EOF"
#!/bin/bash

ENTRADA="$HOME/EPNro1/entrada"
SALIDA="$HOME/EPNro1/salida/$FILENAME"
PROCESADO="$HOME/EPNro1/procesado"

touch "$SALIDA"

while true; do
  for archivo in "$ENTRADA"/*; do
    [ -f "$archivo" ] || continue

    while read -r linea; do
      if ! grep -Fxq "$linea" "$SALIDA"; then
        echo "$linea" >> "$SALIDA"
      fi
    done << "$archivo"

    mv "$archivo" "$PROCESADO/"
  done

  sleep 10
done
EOF

#Para validarlo como ejecutable.
      chmod +x "$HOME/EPNro1/consolidar.sh"
			echo "Entorno creado."
			;;
		2)
			"$HOME/EPNro1/consolidar.sh" &
			echo "Proceso en ejecución..."
			;;
		3)
      if [ -f "$HOME/EPNro1/salida/$FILENAME" ]; then
        sort -k1,1n "$HOME/EPNro1/salida/$FILENAME"
      else
        echo "Archivo no creado aún."
      fi
      ;;			
		4)
      if [ -f "$HOME/EPNro1/salida/$FILENAME" ]; then
    #Más intuitivo declarar nombres y apellidos por separado con un solo espacio.
        sort -k5,5nr "$HOME/EPNro1/salida/$FILENAME" | head -n 10
      else
        echo "Archivo no creado aún."
      fi
      ;;
    5)
      if [ -f "$HOME/EPNro1/salida/$FILENAME" ]; then
        read -p "Ingrese el número de padrón: " padron
        grep "^$padron " "$HOME/EPNro1/salida/$FILENAME"
      else
        echo "Archivo no creado aún."
			fi
      ;;
    6)
      echo "Saliendo..."
			break
			;;
#En caso de que no se escriba un número entre el 1 y el 6.
		*)
			echo "Opción fuera del rango."
			;;
	esac
done
