#!/bin/bash

#se va a ejecutar un bucle infinito
while true;do
	#busca archivo txt en carpeta de "entrada"
	for archivo in "$HOME/EPNro1/entrada"/*.txt;do
		if [ -f "$archivo" ]; then
            		# 1. Agrega el contenido al archivo FILENAME en la carpeta salida
            		cat "$archivo" >> "$HOME/EPNro1/salida/$FILENAME.txt"
            		# 2. Mueve el archivo procesado para que no se vuelva a leer
            		mv "$archivo" "$HOME/EPNro1/procesado/"
		fi
	done
done
