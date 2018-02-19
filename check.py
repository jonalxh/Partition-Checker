# -*- encoding: utf-8 -*-
# AUTHOR: Jonathan Arias G - 2018
import subprocess
import smtplib
from email.mime.text import MIMEText

problems = False
df_usage = subprocess.Popen("df -h --output=pcent -x tmpfs -x devtmpfs", stdout=subprocess.PIPE, shell=True)
df_full = subprocess.Popen("df -h --output=source,pcent -x tmpfs -x devtmpfs", stdout=subprocess.PIPE, shell=True)
usage=df_usage.stdout.read()
full=df_full.stdout.read()
disk2 = usage.split()

for item in disk2:
	if item != 'Uso%' and item != 'Usage%':
		if item >= '70%':
			problems = True
if problems == True:
	hostname = subprocess.Popen("cat /etc/hostname", stdout=subprocess.PIPE, shell=True)
	hostname = hostname.stdout.read().split()
	message = "¡Hola! Actualmente hay una partición del equipo <<"+ hostname[0] +">> con más del 70% de uso: \n\n" + full
	msg = MIMEText(message)
	msg['Subject'] = 'Partition checker'
	msg['From'] = 'Partition checker'
	msg['To'] = 'x@dominio.com'
	username = 'x@dominio.com'
	password = 'xxx'
	email_list = ['a@g.com', 'y@dominio.com', 'z@gmail.com']
	
	try:
		server = smtplib.SMTP('smtp.gmail.com:587')
		server.starttls()
		server.login(username,password)
		server.sendmail('x@dominio.com', email_list, msg.as_string() )
		server.quit()
		#print ("Envio realizado correctamente")
	except Exception as e:
		print e