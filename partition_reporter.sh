#!/bin/bash
###### Copyright: Jonathan Arias González ###########
# Este script utiliza la librería swaks para el envío de emails,
# en caso de no estar instalado: sudo apt-get install swaks
####### Configuración del script #######

SUBJECT="Aviso de uso de disco duro"
RECEIVER="correo@dominio.com"  #Quien recibe
#TEXT="Veamos si funciona esto"

SERVER_PORT="smtp.gmail.com:587"
SENDER="correo@dominio.com" #Quien envía
USER="correo@dominio.com" 
PASSWORD="tucontraseña"

# Aqui se deben definir las particiones a revisar
partitions[0]=/dev/sda1
partitions[1]=/dev/mapper/vg0-root
partitions[2]=/dev/mapper/vg0-db
partitions[3]=/dev/mapper/vg0-backup
partitions[4]=/dev/mapper/vg0-tmp
partitions[5]=/dev/mapper/vg0-media
partitions[6]=/dev/mapper/vg0-www
partitions[7]=/dev/mapper/vg0-log
#....

####### Cuerpo del script ########
 
# Recorremos el array de particiones a monitorizar
for partition in ${partitions[@]};
do
   ip=$( ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/') #Consulto la IP Local
   vpn=$( ip addr | grep 'state UNKNOWN' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/') #Consulto si tiene alguna VPN
   # Consultamos la ocupación de la partición
   ocupacion=$(df -H | grep $partition | expand | tr -s " " | cut -d " " -f5 | cut -d "%" -f1)
   # Si la ocupación es igual o mayor al 70%...
   if [ $ocupacion -ge 70 ];
   then
   		# Preparación y envío del correo
		TEXT=$(echo "PARTICIÓN: $partition se encuentra al $ocupacion% de uso. \n EQUIPO: `hostname` \n IP: $ip (local) - $vpn (VPN)")

		swaks --to $RECEIVER --from $SENDER --server $SERVER_PORT --auth LOGIN --auth-user $USER --auth-password $PASSWORD -tls --data "Date: %DATE%\nTo: %TO_ADDRESS%\nFrom: %FROM_ADDRESS%\nSubject: $SUBJECT \nX-Mailer: swaks v$p_versionjetmore.org/john/code/swaks/\n%NEW_HEADERS%\n $TEXT \n"
	  # %DATE% \n para poner la fecha en el correo
   fi
done
