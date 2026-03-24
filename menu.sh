#!/bin/bash

if [ "$1" == "-d" ]; then
	echo "Eliminando entorno y matando procesos..."

	pkill -f "$HOME/EPNro1/consolidar.sh"
	rm -rf "$HOME/EPNro1"

	echo "Limpieza completada."
	exit 0
fi

export FILENAME="FILENAME.txt"
export ENTRADA="$HOME/EPNro1/entrada"
export SALIDA="$HOME/EPNro1/salida"
export PROCESADO="$HOME/EPNro1/procesado"
export ARCHIVO="$HOME/EPNro1/salida/$FILENAME"

while true; do
	echo "========================="
	echo "   GESTIÓN DE ALUMNOS    "
	echo "========================="
	echo "1. Crear entorno"
	echo "2. Iniciar proceso"
	echo "3. Listar alumnos"
	echo "4. Top 10 calificaciones"
	echo "5. Buscar por padrón"
	echo "6. Salir"
	echo "-------------------------"

	read -p "Opción: " opcion
	echo ""
    
	case $opcion in
		1)
			mkdir -p "$ENTRADA" "$SALIDA" "$PROCESADO"
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
				echo "El proceso de consolidación ya está en ejecución."
			else
				"$HOME/EPNro1/consolidar.sh" &
				echo "Proceso de consolidación iniciado."
			fi
			;;
		3)
			if [ -f "$ARCHIVO" ]; then
				echo "Listado de alumnos (ordenados por padrón):"
				echo "--------------------------------------------------"
				sort -k1,1n "$ARCHIVO"
			else
				echo "Sin datos disponibles. Cree el entorno y ejecute el proceso."
			fi
			;;
		4)
			if [ -f "$ARCHIVO" ]; then
				echo "Top 10 calificaciones:"
				echo "--------------------------------------------------"
				sort -k5,5nr "$ARCHIVO" | head -n 10
			else
				echo "Sin datos disponibles. Cree el entorno y ejecute el proceso."
			fi
			;;
		5)
			if [ -f "$ARCHIVO" ]; then
				read -p "Ingrese el número de padrón: " padron

				if ! [[ "$padron" =~ ^[0-9]+$ ]]; then
    				echo "Ingrese un padrón válido."
    			continue
				fi
			
    			if ! grep "^$padron " "$ARCHIVO"; then
    				echo "No se encontró ningún alumno con el padrón ingresado."
    			fi
				
			else
				echo "Sin datos disponibles. Cree el entorno y ejecute el proceso."
			fi
			;;
		6)
			echo "Saliendo..."
			break
			;;
		*)
			echo "Opción fuera de rango. Ingrese una opción válida."
			;;
	esac

	echo ""
done
