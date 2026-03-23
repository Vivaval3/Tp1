#!/bin/bash
# Configuración de la variable de ambiente (con respaldo por si no existe)

#export FILENAME="archivos_alumnos"
#mi_variable=${FILENAME}

if [ -z "$FILENAME"  ];then
	export FILENAME="archivos_alumnos"
fi

echo "$FILENAME"

#DEFINICION GLOBAL:
FILE_PATH="$HOME/EPNro1/salida/$FILENAME.txt"

#eliminamos el entorno creado 
if [ "$1" == "-d" ]; then
    echo "Eliminando entorno y procesos..."
    rm -rf "$HOME/EPNro1"
    pkill -f "consolidar.sh"
    exit 0
fi

# El Menú
while true; do
	echo "--- MENÚ DE OPERACIONES ---"
	echo "1) Crear entorno"
	echo "2) Correr proceso (background)"
	echo "3) Listar alumnos por padrón"
	echo "4) Ver 10 notas más altas"
	echo "5) Buscar padrón"
	echo "6) Salir"
	echo ""
	read -p "Seleccione una opción: " opcion
	
	case $opcion in
        	1)
			#Crea el entorno y los directorios de Entrada, salida y Procesado y copiar el consolidar.sh en  EPNro1
			mkdir -p "$HOME/EPNro1/entrada" "$HOME/EPNro1/salida" "$HOME/EPNro1/procesado"
			cp ./consolidar.sh /$HOME/EPNro1/consolidar.sh
			echo -e "\nEntorno creado\n"
            		;;
        	2)
            		# Ejecuta el script consolidar.sh en segundo plano
            		$HOME/EPNro1/consolidar.sh &
            		echo -e "\nProceso iniciado en background\n"
            		;;
		3)
			#Se muestra el listado de los alumnos por número de padrón
			# -n: orden numérico, -t: separador (asumimos coma), -k1: primera columna
        		if [ -f "$FILE_PATH" ]; then
				echo ""
            			sort -n -t ',' -k1 "$FILE_PATH"
			else
				echo -e  "\nel archivo no está creado aún\n"
        		fi
        		;;
		4)
			#Muestra en pantalla las 10 notas más altas
			if [ -f "$FILE_PATH" ]; then
        			echo "--- Top 10 Notas más altas ---"
				echo ""
        			# -r: reverso (mayor a menor), -n: numérico, -k4: cuarta columna (nota)
        			sort -rn -t ',' -k4 "$FILE_PATH" | head -n 10
				echo ""
    			else
        			echo -e "\nEl archivo $FILENAME.txt no existe\n"
    			fi
    			;;
		5)
			#Solicita al usuario el número de padrón y lo busca en FILENAME
			if [ -f "$FILE_PATH" ]; then
				echo ""
        			read -p "Ingrese el número de padrón a buscar: " padron_buscado
        			# -w: busca la palabra exacta (para que el padrón 10 no coincida con 100)
        			resultado=$(grep -w "^$padron_buscado" "$FILE_PATH")
        
        			if [ -z "$resultado" ]; then
            				echo "No se encontró el padrón $padron_buscado."
        			else
            				echo "Datos encontrados: $resultado"
        			fi
    			else
        			echo "El archivo $FILENAME.txt no existe."
    			fi
    			;;
			
		6)
			echo "Adios!"
			exit 0
			;;
		*)
			echo -e "\nopción inválida\n"
			;;
	esac
done
