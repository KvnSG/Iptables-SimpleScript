#!/bin/bash

# Función para mitigar la conexión
mitigar() {
    iptables -I INPUT -p tcp --dport 80 -m connlimit --connlimit-above 20 --connlimit-mask 40 -j DROP
    echo "Regla de mitigación aplicada."
}

# Función para permitir la conexión
permitir() {
    iptables -D INPUT -p tcp --dport 80 -m connlimit --connlimit-above 20 --connlimit-mask 40 -j DROP
    echo "Regla de mitigación eliminada. Conexiones permitidas."
}

# Verificar argumento
if [ "$#" -ne 1 ]; then
    echo "Uso: $0 [mitigar|permitir]"
    exit 1
fi

# Ejecutar la opción seleccionada
case "$1" in
    "mitigar")
        mitigar
        ;;
    "permitir")
        permitir
        ;;
    *)
        echo "Opción no válida. Uso: $0 [mitigar|permitir]"
        exit 1
        ;;
esac

exit 0
