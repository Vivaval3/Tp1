#!/bin/bash

if [ "$1" == "-d" ]; then
	echo "Eliminando entorno y matando procesos..."

	pkill -f "$HOME/EPNro1/consolidar.sh"
	rm -rf "$HOME/EPNro1"

	exit 0
fi

export FILENAME="FILENAME.txt"
export ENTRADA="$HOME/EPNro1/entrada"
export SALIDA="$HOME/EPNro1/salida"
export PROCESADO="$HOME/EPNro1/procesado"
export ARCHIVO="$HOME/EPNro1/salida/$FILENAME"

while true; do
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
			mkdir -p "$ENTRADA"
			mkdir -p "$SALIDA"
			mkdir -p "$PROCESADO"

			cat > "$HOME/EPNro1/consolidar.sh" << "EOF"
#!/bin/bash
touch "$ARCHIVO"

while true; do
  flag=false

  for archivo in "$ENTRADA"/*; do
    [ -f "$archivo" ] || continue

    cat "$archivo" >> "$ARCHIVO"
    mv "$archivo" "$PROCESADO/"
    flag=true
  done

  $flag && sort -u "$ARCHIVO" -o "$ARCHIVO"

  sleep 10
done
EOF
      
			chmod +x "$HOME/EPNro1/consolidar.sh"
			echo "Entorno creado."
			;;
		2)
      if pgrep -f "$HOME/EPNro1/consolidar.sh" > /dev/null; then
        echo "Proceso ya ejecutado."
      else
        "$HOME/EPNro1/consolidar.sh" &
        echo "Proceso en ejecución..."
      fi
      ;;
		3)
      if [ -f "$ARCHIVO" ]; then
        sort -k1,1n "$ARCHIVO"
      else
        echo "Archivo no creado aún."
      fi
      ;;			
		4)
      if [ -f "$ARCHIVO" ]; then
        sort -k5,5nr "$ARCHIVO" | head -n 10
      else
        echo "Archivo no creado aún."
      fi
      ;;
    5)
      if [ -f "$ARCHIVO" ]; then
        read -p "Ingrese el número de padrón: " padron
        grep "^$padron " "$ARCHIVO"
      else
        echo "Archivo no creado aún."
			fi
      ;;
    6)
      echo "Saliendo..."
			break
			;;
		*)
			echo "Opción fuera del rango."
			;;
	esac
done
