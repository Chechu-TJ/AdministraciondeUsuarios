#!/bin/bash
# Menu para mostrar las funciones del script

menu(){ 
echo -e "\n"
echo "Elige que función quieres realizar:"
echo -e "\n"
echo "1 Añadir un nuevo usuario"
echo "2 Eliminar un usuario"
echo "3 Modificar parámetros de usuario y de grupo" 
echo "4 Crear un nuevo grupo" 
echo "5 Borrar un grupo" 
echo "6 Salir del script" 
read -p "Introduce el numero que corresponde al menu de arriba: " Variable1
echo -e "\n" "_______________________________________________________________________________"
}

menu-tool(){
echo -e "\n"
echo "Elige que función de 'Modificar' quieres realizar:"
echo -e "\n"
echo "1 Modificar el nombre de un usuario"
echo "2 Modificar la Shell de un usuario"
echo "3 Cambiar el nombre de la carpeta home/xxx"
echo "4 Cambiar el grupo primario y,o añadir un grupo secundario a un usuario"
echo "5 Modificar el nombre de un grupo"
echo "6 Cambiar la contraseña de un usuario"
echo "7 Bloquear o poner la contraseña de un usuario en standby"
echo "7.1 Desbloquear la contraseña de usuario"
echo "8 Cambiar el propietario de un archivo o carpeta"
echo "9 Cambiar los permisos de un archivo"
echo "10 Volver atras"
echo -e "\n" "_______________________________________________________________________________"

}

echo -e "\t""BIENVENIDO AL SCRIPT"
echo "GESTIONAR Y ADMINISTRACION DE USUARIOS"
echo -e "\n"

# Aqui hacemos un bucle while por si se confunde que lo haga otra vez

while [ true ]; do
# Aqui llamamos la funcion "menu"
menu
case $Variable1 in 

	1) echo "Has elegido la opción --Añadir un nuevo usuario--"
		while true; do
		read -p "Como quieres llamar al nuevo usuario: " UsuarioNuevo
		echo -e "\n"
		read -p "Estas seguro que quieres poner $UsuarioNuevo como nombre de usuario (Y/N): " Respuesta
		case $Respuesta in 
			"Y" | "y")sudo useradd -m $UsuarioNuevo
			echo "Ahora vamos a poner contraseña al usuario $UsuarioNuevo"
			sudo passwd $UsuarioNuevo
			echo -e "\n"
			sudo grep -w "$UsuarioNuevo" /etc/passwd && sudo grep -w "$UsuarioNuevo" /etc/shadow
			echo "usuario creado con éxito"
			echo "Arriba se muestra el usuario y la contraseña cifrada"		
			break 
			;;
			"N"| "n")
			;;
		esac
		done	
		
	;;
	2)echo "Has elegido la opción --Eliminar un usuario--"
	echo -e "\n"

	
		while true; do
		read -p "Quieres ver los usuarios que tienes en el sistema (Y/N): " Respuesta2
		case $Respuesta2 in
		"Y" | "y") sudo cat /etc/passwd
			break 
		;;
		"N" | "n") break 
		;;
		*) echo "Has introducido un valor incorrecto , responde "Y" o "N"."
			
		;;
		esac
		done
	echo -e "\n"	
	read -p "Que usuario quieres eliminar: " Respuesta3
	sudo userdel -r $Respuesta3
	echo "El usuario $Respuesta3 has sido eliminado"
	echo -e "\n"	
	;;
	3)echo "Has elegido la opción --Modificar parámetros de un usuario--"
	while true; do
		menu-tool
		echo -e "\n"
		read -p "Elige la opción que deseas hacer: " Respuesta4
		case $Respuesta4 in 
			1) echo "Has elegido la opción --Modificar el nombre de un usuario--"
			echo -e "\n"
			while true; do
			read -p "Quieres ver los usuarios que tienes en el sistema (Y/N): " Respuesta2
			case $Respuesta2 in
			"Y" | "y") sudo cat /etc/passwd
			break 
			;;
			"N" | "n") break 
			;;
			*) echo "Has introducido un valor incorrecto , responde "Y" o "N"."
			
			;;
			esac
			done
			while true; do
			echo -e "\n"
			read -p "¿Que nombre ya existente quieres cambiar el nombre?: " Respuesta5
			if grep -w ^$Respuesta5 /etc/passwd ; then
			echo "El usuario $Respuesta5 existe"
			break
			else 
			echo "El usuario no $Respuesta5 existe, intentalo de nuevo"
			fi
			done
			
			echo -e "\n"
			while true; do
			read -p "¿Que nuevo nombre de usuario vas a utilizar?: " Respuesta6
			read -p "¿Estas seguro de poner '$Respuesta6' como nuevo nombre de usuario? (Y/N): " Respuesta7
				case $Respuesta7 in 
					"Y" | "y")sudo usermod -l $Respuesta6 $Respuesta5
					echo -e "\n"
					sudo grep -w "$Respuesta6" /etc/passwd 
					echo "Operación realizada con éxito"
					echo "Arriba se muestra el nuevo nombre del usuario cambiado"
					break 
					;;
					"N"| "n") echo "Prueba otra vez"
					;;
					*) echo "Has introducido un valor incorrecto , responde "Y" o "N"."
					;;
					
				esac
				done
				
		
		;;
		2)echo "Has elegido la opción --Modificar la Shell de un usuario--"
		echo "Mostrando el contenido de /etc/passwd:" 
		cat /etc/passwd 
		echo -e "\n"
		 # Bucle para pedir el nombre del usuario
 		while true; do
 		read -p "Introduce el nombre del usuario al que quieres cambiar el shell: " usuario
 		# Verificar si el usuario existe en /etc/passwd
 		if grep -q "^$usuario:" /etc/passwd; then
 		echo "El usuario $usuario existe." 
 		break
 		else
 		echo "El usuario $usuario no existe. Por favor, introduce un nombre de usuario válido."
 		sleep 2s
 		fi 
 		done
		while true; do
		 # Preguntar por el nuevo shell que se desea asignar
		 echo "Elige el tipo de shell que quieres asignar:"
		 echo "1. /bin/bash" 
		 echo "2. /bin/sh"
	 	 echo "3. /bin/zsh"
	 	 read -p "Tipo se shell: " shell
	 	 
	 	# Determinar el shell basado en la elección del usuario 
			case $shell in
	 		1) sudo usermod -s  /bin/bash $usuario 
	 		break 
	 		;;
 			2) sudo usermod -s /bin/sh $usuario
 			break 
 			;;
 			3) sudo usermod -s /bin/zsh $usuario
 			break 
 			;; 
	 		*) echo "Opción no válida. Por favor, elige nuevamente." ;;
	 		esac
	 	done 
		 
		 # Confirmar el cambio 
		 if [ $? -eq 0 ]; then 
		echo "El shell del usuario $usuario ha sido cambiado con éxito."
		sudo grep -w "$usuario" /etc/passwd
	 	else 
		echo "Hubo un error al cambiar la shell del usuario $usuario."
		fi
		
		
		;;
		3) echo "Has elegido la opción --Cambiar el nombre de la carpeta home/xxx--"
		echo -e "\n"
		echo "Mostrando los usuarios existentes en el sistema:"
		sudo cat /etc/passwd
		echo -e "\n"

		# Bucle para pedir el nombre del usuario y el nuevo nombre
		while true; do
  		  read -p "Introduce el nombre del usuario que quieres cambiar el nombre de la carpeta /home/xxx: " home_usuario

   		 # Verificar si el grupo existe en /etc/passwd
   		 if grep -q "^$home_usuario:" /etc/passwd; then
    		    echo "El grupo '$home_usuario' existe."
    		    break
   		 else
    		    echo "El grupo '$home_usuario' no existe. Por favor, introduce un nombre de grupo válido."
    		    sleep 2s
   		 fi
		done

	# Confirmar la opción con un "case"
	while true; do
		read -p "Introduce el nuevo nombre que vas a asignar a la carpeta /home/" home_nombre
	    read -p "Has introducido '$home_nombre'. ¿Estás seguro que quieres llamarlo /home/$home_nombre? (Y/N): " 		confirmacion_home
  	  case $confirmacion_home in
     	   "Y" | "y")
          	if sudo usermod -d  /home/$home_nombre $home_usuario ; then
                	echo "El usuario '$home_usuario' ha sido cambiado el directorio con éxito."
                	sudo grep -w ^$home_usuario /etc/passwd
                	break   # Sale de los dos bucles
            	else
             	   echo "Hubo un error al cambiar de directorio. Por favor, intenta nuevamente."
              	  break  # Sale del bucle de confirmación
           	 fi
           	 ;;
        	"N" | "n")
         	   echo "Vamos a intentarlo de nuevo."
           	 
          	  ;;
       		 *)
           	 echo "Opción no válida. Por favor, responde Y o N."
            	;;
   	 esac
	done
	
		;;
		4)echo "Has elegido la opción --Cambiar el grupo primario y secundario de un usuario--"
		while true; do
		read -p "¿Quieres cambiar el grupo primario a algún usuario? (Y/N): " kf1
		case $kf1 in
     	   "Y" | "y")
          	while true; do
          	sudo cat /etc/passwd
          	read -p "Que usuario quieres cambiar su grupo primario: " kf2
          	if grep -q "^$kf2:" /etc/passwd ; then
          	echo "Has elegido a $kf2 para cambiarle de grupo"
          		while true;do
          		sudo cat /etc/group
          		read -p "Que grupo vas a asignarle como principal: " kf3
          		if grep -q "^$kf3:" /etc/group ; then
          		echo "Has seleccionado el grupo $kf3"
          		sudo usermod -g $kf3 $kf2
          		id $kf2
          		echo "El proceso ha salido correctamente"
          		break 2
          		else
          		echo "El grupo $kf3 no existe, intentelo de nuevo"
          		sleep 2s
          		fi
          		done
          	
          	else 
          	echo "El usuario $kf2 no existe, intentalo de nuevo"
          	sleep 3s
          	fi
          	done
          	
          	
          	
           	 ;;
        	"N" | "n") echo -e "\n"
         	   read -p "¿Quieres añadir a algún usuario a un grupo secundario? (Y/N) : " tl1
           	 	while true; do
           	 	case $tl1 in
           	 	 "Y" | "y")
           	 	 while true; do
          		sudo cat /etc/passwd
          		echo -e "\n"
          		read -p "Que usuario quieres añadir a un grupo secundario: " tl2
          		if grep -q "^$tl2:" /etc/passwd ; then
          		echo "Has elegido a $kf2 para añadirle de grupo"
          			while true;do
          			sudo cat /etc/group
          			read -p "Que grupo vas a asignarle como secundario: " tl3
          			if grep -q "^$tl3:" /etc/group ; then
          			echo "Has seleccionado el grupo $tl3"
          			sudo usermod -aG $tl3 $tl2
          			id $tl2
          			echo "El proceso ha salido correctamente"
          			break 3
          			else
          			echo "El grupo $tl3 no existe, intentelo de nuevo"
          			fi
          			done
          	
          		else 
          		echo "El usuario $tl2 no existe, intentalo de nuevo"
          		sleep 3s
          		fi
          		done
           	 	 
           
           	 	 
           	 	 ;;
           	 	 "N" | "n") break 2
           	 	 ;;
           	 	 *) echo "Opción no válida. Por favor, responde Y o N."
           	 	 ;;
           	 	
           	 	esac
           	 	
           	 	done
           	 	
          	  ;;
       		 *)
           	 echo "Opción no válida. Por favor, responde Y o N."
            	;;
		esac
		done
		
		;;
		5) echo "Has elegido la opción --Modificar el nombre de un grupo--"
		while true; do
		sudo cat /etc/group
		read -p "¿Que grupo quieres cambiar el nombre?: " gpn1
		if grep ^$gpn1 /etc/group ; then
		echo "El nombre '$gpn1' existe"
		break
		else
		echo " El nombre '$gpn1' no existe, intentalo de nuevo"
		sleep 2s
		fi
		done
		while true; do
		read -p "¿Que nuevo nombre vas a poner?: " gpn2
		read -p "Vas a poner el nombre '$gpn2' ¿Estas seguro de poner este nombre? (Y/N): " gpn3
			case $gpn3 in
			 "Y" | "y") sudo groupmod -n $gpn2 $gpn1
			 	 grep -w $gpn2 /etc/group
			 	 echo "Se ha cambiado correctamente el nombre"
			 	 break
			 ;;
			  "N" | "n")
			  ;;
			  *) echo "Opción no válida. Por favor, responde Y o N."
			  ;;
			esac
		
		done
		
		
		;;
		6)echo "Has elegido la opción --Cambiar la contraseña de un usuario--"
		echo -e "\n"
		while true; do
		sudo cat /etc/passwd
		echo -e "\n"
		read -p "¿Que usuario quieres cambiar la contraseña?: " pwc
		if grep "$pwc" /etc/passwd ; then
		echo "Existe el usuario '$pwc'"
		sudo passwd $pwc
			if [  $? -eq 0 ] ; then 
			echo "Se ha cambiado correctamente la contaseña al usuario '$pwc'"
			else
			echo "Ha habido un fallo al cambiar la contraseña"
			fi
		
			break
		else 
		echo "El usuario '$pwc' no existe, inténtalo de nuevo"
		sleep 2s
		fi
		done
		
		;;
		7)echo "Has elegido la opción --Bloquear o poner la contraseña de usuario en standby--"
		echo -e "\n"
		while true; do
		sudo cat /etc/passwd
		echo -e "\n"
		read -p "¿Que usuario quieres bloquear la contraseña?: " pwc
		if grep "$pwc" /etc/passwd ; then
		echo "Existe el usuario '$pwc'"
		sudo passwd -l $pwc
			if [  $? -eq 0 ] ; then 
			echo "Se ha bloqueado correctamente la contaseña al usuario '$pwc'"
			else
			echo "Ha habido un fallo al bloquear la contraseña"
			fi
		
			break
		else 
		echo "El usuario '$pwc' no existe, inténtalo de nuevo"
		sleep 2s
		fi
		done
		
		
		
		;;
		7.1)echo "Has elegido la opción --Desbloquear la contraseña de usuario--"
		echo -e "\n"
		while true; do
		sudo cat /etc/passwd
		echo -e "\n"
		read -p "¿Que usuario quieres desbloquear la contraseña?: " pwc
		if grep "$pwc" /etc/passwd ; then
		echo "Existe el usuario '$pwc'"
		sudo passwd -u $pwc
			if [  $? -eq 0 ] ; then 
			echo "Se ha desbloqueado correctamente la contaseña al usuario '$pwc'"
			else
			echo "Ha habido un fallo al desbloquear la contraseña"
			fi
		
			break
		else 
		echo "El usuario '$pwc' no existe, inténtalo de nuevo"
		sleep 2s
		fi
		done
		
		;;
		8)echo "Has elegido la opción --Cambiar el propietario de un archivo o carpeta--"

		# Llamar a la función de navegación
		source navegar.sh

		# Después de navegar, solicitar información para gestionar permisos
	
		while true; do
		echo -e "\n"
		read -p "Introduce el nuevo propietario: " USUARIO
		if grep -w $USUARIO /etc/passwd ; then
		echo "El usuario $USUARIO existe"
		break
		else
		echo "El usuario $USUARIO no existe, te mostrare la lista de usuario para ayudarte"
		sleep 2s
		sudo cat /etc/passwd
		fi
		done
	
		while true; do
		echo -e "\n"
	
		read -p "¿Quieres cambiar de grupo el archivo o directorio (opcional)? (Y/N): " ask
		case $ask in
		"Y" | "y")
		
			while true; do
			read -p "Introduce el grupo: " GRUPO
			if grep -w $GRUPO /etc/group ; then
			echo "El grupo $GRUPO es correcto"
			echo -e "\n"
			break 2
			else
			echo  "El grupo $GRUPO no existe, intentalo otra vez"
			sleep 2s
			sudo cat /etc/group
			fi
			done
			;;
			"N" | "n")
			break
			;;
			*) echo "Opción no válida. Por favor, responde Y o N."
			;;
		esac
		done
	
	
	

		# Cambiar propietario del archivo o directorio
		if [ -z "$GRUPO" ]; then
 		 sudo chown $USUARIO "$DIR_COMPLETA"
 		 echo "Propietario de "$DIR_COMPLETA" cambiado a $USUARIO"
 		 echo -e "\n"
 		 echo "Cambios completados. ¡Proceso finalizado!"
		ls -l "$DIR_COMPLETA"

		else
 		 sudo chown $USUARIO:$GRUPO "$DIR_COMPLETA"
 		 echo "Propietario y grupo de "$DIR_COMPLETA" cambiado a $USUARIO:$GRUPO"
 		 echo "Cambios completados. ¡Proceso finalizado!"
 	 	 ls -l "$DIR_COMPLETA"
		fi

		;;
		9)echo "Has elegido la opción --Cambiar los permisos de un archivo--"
		
		echo "Ahora tendrás que buscar el archivo o directorio que cambiaras los permisos"
		echo "Se paciente"
		sleep 3s
		source navegar.sh
		
		while true; do
		
		read -p "Como lo quieres hacer,¿en formato -1.Octal- o con -2.Letras- ej (u+x)?: " ask
		
		case $ask in
		"1") 
		echo -e "\n"
		echo "Has elegido --Formato Octal--"
		while true; do
			
			echo -e "\n"
			read -n3 -p  "Introduce los valores correspondientes (4=r,2=w,1=x,0=-): " input
			if [[ "$input" =~ ^[0-7]{3}$ ]]; then
				echo " Entrada valida: $input"
				sudo chmod $input $DIR_COMPLETA
				ls -l $DIR_COMPLETA
				echo "Operación realizada correctamente"
				break 2
				
			else
				echo -e "\n"
				echo "$input Entrada invalida. Introduce correctamente los tres dígitos" 
			fi
			done
		;;
		"2") echo -e "\n"
		echo "Has elegido --Formato Letra--"
		echo -e "\n"
		while true ; do
			 ls -l "$DIR_COMPLETA"
			read -p "Escribe la modificación que quieres realizar como (u+x, go-x, a+rwx): " modificacion
			sudo chmod $modificacion "$DIR_COMPLETA" 2>/dev/null
			if [ $? -eq 0 ] ; then 
				echo "La operación ha salido con éxito"
				ls -l "$DIR_COMPLETA"
				break 2
			else 
			echo "$modificacion no existe como argumento,vuelve a intentarlo"
			echo "Si tienes alguna duda pincha aquí 'https://www.arsys.es/blog/comandos-chmod-chown'"
			fi
	
		done
		;;
		*) echo "Valor incorrecto, escribe '1' o '2'"
		;;
		
		
		
		esac
		done
		
		
		
		
		
		
		
		
		;;
		10) break
		;;
		*) echo "Valor no valido, introduce un valor del 1 al 10 "
		;;
	
		esac
	done
	
	;;
	4) echo "Has elegido la opción --Crear un nuevo grupo--"
	echo -e "\n"
	while true; do
   	 read -p "Introduce el nombre del grupo que quieres crear: " grupo

  	  # Confirmar la opción con un "case"
  	  while true; do
     	   read -p "Has introducido '$grupo'. ¿Estás seguro que quieres crear este grupo? (Y/N): " confirmacion
     	   case $confirmacion in
      	      "Y" | "y")
                sudo groupadd "$grupo"
                    echo "El grupo '$grupo' ha sido creado con éxito."
                    sudo grep -w "$grupo" /etc/group
                    echo -e "\n"
                    break 2 
               
                ;;
            "N" | "n")
                
                break  
                ;;
            *)
                echo "Opción no válida. Por favor, responde Y o N."
                ;;
     	   esac
   	 done
	done
	
	;;
	5) echo "Has elegido la opción --Borrar un grupo--"
	echo -e "\n"
	echo "Mostrando los grupos existentes en el sistema:"
	sudo cat /etc/group
	echo -e "\n"

	# Bucle para pedir el nombre del grupo y verificar si existe
	while true; do
  	  read -p "Introduce el nombre del grupo que quieres eliminar: " grupo_eliminar

   	 # Verificar si el grupo existe en /etc/group
   	 if grep -q "^$grupo_eliminar:" /etc/group; then
    	    echo "El grupo '$grupo_eliminar' existe."
    	    break
   	 else
    	    echo "El grupo '$grupo_eliminar' no existe. Por favor, introduce un nombre de grupo válido."
   	 fi
	done

	# Confirmar la opción con un "case"
	while true; do
	    read -p "Has introducido '$grupo_eliminar'. ¿Estás seguro que quieres eliminar este grupo? (Y/N): " 		confirmacion_eliminar
  	  case $confirmacion_eliminar in
     	   "Y" | "y")
          	if sudo groupdel "$grupo_eliminar"; then
                	echo "El grupo '$grupo_eliminar' ha sido eliminado con éxito."
                	break 2  # Sale de los dos bucles
            	else
             	   echo "Hubo un error al eliminar el grupo. Por favor, intenta nuevamente."
              	  break  # Sale del bucle de confirmación
           	 fi
           	 ;;
        	"N" | "n")
         	   echo "Vamos a intentarlo de nuevo."
           	 break  # Sale del bucle de confirmación para pedir el nombre del grupo de nuevo
          	  ;;
       		 *)
           	 echo "Opción no válida. Por favor, responde Y o N."
            	;;
   	 esac
	done
	
	;;
	6) echo "Hasta la próxima amigo"
	break
	;;
	*)
	echo -e "\n"
	sleep 3s
	echo "Te has equivocado :( ,introduce 1,2 o 3. Inténtalo otra vez :)." 
	echo -e "\n"
	;;
esac
done