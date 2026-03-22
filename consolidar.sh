#!/bin/bash

while true; do
  for archivo in "$HOME/EPNro1/entrada"/*; do
    if [ -f "$archivo" ];then
      cat "archivo">> "$HOME/EPNro1/salida/$FILENAME"
      mv "$archivo" "$HOME/EPNro1/salida/procesado/"
    fi
  done
  sleep 2 
done
  
