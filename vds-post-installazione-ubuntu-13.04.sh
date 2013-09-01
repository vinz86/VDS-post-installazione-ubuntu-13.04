#!/bin/bash

function codec {
echo
echo "********************** Installazione codec e plugin **********************"
echo -n "# Procedo con l'installazione? "
read sure
if [[ $sure = "s" ]]
	then
        sudo apt-get install -y ubuntu-restricted-extras libavformat-extra-53 libavcodec-extra-53
		echo "* Installazione codec e plugin terminata."
	else 
		echo "* Installazione codec e plugin non eseguita."
fi
}

#Installazione di programmi preferiti alla prima installazione di UBUNTU
function softpreferiti {
echo
echo "********************** Installazione software preferiti **********************"
echo -n "# Procedo con l'installazione? "
read sure
if [[ $sure = "s" ]]
	then
		#Installazione software
		sudo apt-get install -y chromium-browser unity-tweak-tool gimp gimp-plugin-registry imagemagick inkscape openshot cheese vlc audacity easytag filezilla p7zip-full keepassx unrar synaptic  gparted virtualbox-qt
		echo "* Installazione software preferiti terminata."
	else 
		echo "* Installazione software preferiti non riuscita."
fi
}

function softesterni {
echo
echo "********************** Installazione software con repository esterni **********************"
echo -n "# Procedo con l'installazione? "
read sure
if [[ $sure = "s" ]]
	then
		#Installazione software con repository esterni
		#AGGIUNTA REPOSITORY
		sudo add-apt-repository ppa:jd-team/jdownloader
		sudo add-apt-repository ppa:noobslab/apps #indicator synapse
		sudo add-apt-repository ppa:tiheum/equinox #faenza icon
		#AGGIORNAMENTO
		sudo apt-get update
		#INSTALAZIONE
		sudo apt-get install jdownloader  -y
		sudo apt-get install indicator-synapse -y
		sudo apt-get install faenza-icon-theme -y
		echo "* Installazione software con repository esterni terminata."
	else 
		echo "* Installazione software con repository esterni non riuscita."
fi
}

function softremove {
echo
echo "********************** Rimozione software **********************"
echo "
		sudo apt-get purge gnome-contacts deja-dup
		sudo apt-get purge gnome-orca
		sudo apt-get purge thunderbird
		sudo apt-get purge empathy
		sudo apt-get purge ubuntuone
		sudo apt-get purge xul-ext-unity xul-ext-websites-integration
		sudo apt-get purge unity-webapps-common
		sudo apt-get purge unity-lens-music unity-scope-musicstores
		sudo apt-get purge unity-lens-video
		sudo apt-get purge unity-lens-photo
		sudo apt-get purge unity-lens-shopping
"
echo -n "# Rimuovo questi software? "
read sure
if [[ $sure = "s" ]]
	then
		sudo apt-get purge gnome-contacts deja-dup
		sudo apt-get purge gnome-orca
		sudo apt-get purge thunderbird
		sudo apt-get purge empathy
		sudo apt-get purge ubuntuone
		sudo apt-get purge xul-ext-unity xul-ext-websites-integration
		sudo apt-get purge unity-webapps-common
		sudo apt-get purge unity-lens-music unity-scope-musicstores
		sudo apt-get purge unity-lens-video
		sudo apt-get purge unity-lens-photo
		sudo apt-get purge unity-lens-shopping

		sudo updatedb
		echo "* Installazione software essenziali terminata."
	else 
		echo "* Installazione software essenziali non riuscita."
fi
}

function pulizia {
echo
echo "************************* INIZIO PULIZIA DEL SISTEMA *************************"
echo
echo -n "# Rimuovo le dipendenze inutili? Autoremove "
read sure
if [[ $sure = "s" ]]
	then
		sudo apt-get --purge autoremove
		echo "* Rimozione dipendenze inutili...[OK]"
	else 
		echo "* Rimozione dipendenze inutili...[NON ESEGUITO]"
fi

echo
echo -n "# Rimuovo la cache dei pacchetti scaricati dai repository obsoleti? Autoclean "
read sure
if [[ $sure = "s" ]]
	then
		sudo apt-get autoclean
		echo "* Rimozione cache pacchetti obsoleti...[OK]"
	else 
		echo "* Rimozione cache pacchetti obsoleti...[NON ESEGUITO]"
fi
echo
echo -n "# Rimuovo la cache dei pacchetti scaricati dai repository? Clean "
read sure
if [[ $sure = "s" ]]
	then
		sudo apt-get clean
		echo "* Rimozione  cache pacchetti scaricati...[OK]"
	else
		echo "* Rimozione  cache pacchetti scaricati...[NON ESEGUITO]"
fi
echo
echo -n "# Elimino il contenuto di /temp? RM - Temp "
read sure
if [[ $sure = "s" ]]
	then
		sudo rm -rf /tmp/*
		echo "* Eliminazione contenuto /temp...[OK]"
	else 
		echo "* Eliminazione contenuto /temp...[NON ESEGUITO]" 
fi
echo
echo -n "# Elimino il contenuto della directory /.thumbnails? Thumbnails *"
read sure
if [[ $sure = "s" ]]
	then
		sudo rm -rfv ~/.thumbnails/*
		echo "* Eliminazione files da /.thumbnails ...[OK]"
	else 
		echo "*Eliminazione files da /.thumbnails ...[NON ESEGUITO]"
fi
echo
echo -n "# Effettuo una ricerca dei residui di files? .* "
read sure
if [[ $sure = "s" ]]
	then
	find $HOME -name "*~"
	find $HOME -name "Desktop.ini"
	find $HOME -name "Thumbs.db"
	echo -n "# Rimuovo questi residui di file? "
	read sure
	if [ $sure == "s" ]
		then
		find $HOME -name "*~" -print0|xargs -0 /bin/rm -f
		find $HOME -name "Desktop.ini" -print0|xargs -0 /bin/rm -f
		find $HOME -name "Thumbs.db" -print0|xargs -0 /bin/rm -f
		echo "* Eliminazione residui...[OK]"
	else echo "* Eliminazione residui...[NON ESEGUITO]"
	fi
else echo "* Ricerca residui di files...[NON ESEGUITO]"
fi

echo
echo -n "# Elimino configurazioni residue? *"
read sure
if [[ $sure = "s" ]]
	then
	    echo 'Rimozione configurazioni residue dei files...'
	    echo 'Richiede privilegi da root:'
	    sudo dpkg --purge `dpkg -l | egrep "^rc" | cut -d ' ' -f3`
		echo "* Rimozione configurazioni residue dei files ...[OK]"
	else
		echo "* Rimozione configurazioni residue dei files ...[NON ESEGUITO]"
fi

echo
echo -n "# Rimuovo la lista dei files e delle applicazioni recenti"
read sure
if [[ $sure = "s" ]]
	then
		rm ~/.local/share/zeitgeist/activity.sqlite
        #zeitgeist-daemon --replace
		echo "* Rimozione lista dei files e delle applicazioni recenti...[OK]"
	else 
		echo "* Rimozione lista dei files e delle applicazioni recenti...[NON ESEGUITO]"
fi

echo
echo -n "# Elimino le versioni obsolete dei kernel? *"
read sure
if [[ $sure = "s" ]]
	then
	    echo 'Rimozione versioni obsolete dei kernel...'
	     sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt-get -y purge
		echo "* Rimozione versioni obsolete dei kernel ...[OK]"
	else
		echo "* Rimozione versioni obsolete dei kernel ...[NON ESEGUITO]"
fi

echo
echo -n "# Elimino il contenuto del Cestino? Trash *"
read sure
if [[ $sure = "s" ]]
	then
		sudo rm -rfv ~/.local/share/Trash/*
		echo "* Eliminazione files da /Trash ...[OK]"
	else
		echo "* Eliminazione files da /Trash ...[NON ESEGUITO]"
fi

echo
echo "------------------------------ PULIZIA TERMINATA -----------------------------"
echo
}

function aggiornamento {
echo
echo "********************** INIZIO AGGIORNAMENTO DEL SISTEMA **********************"
echo
echo -n "# Aggiorno gli indici dei pacchetti? Update "
read sure
if [[ $sure = "s" ]]
	then
		sudo apt-get update
		echo "* Aggiornamento indici pacchetti...[OK]"
	else 
		echo "* Aggiornamento indici pacchetti...[NON ESEGUITO]"
fi
echo
echo -n "# Aggiorno le chiavi GPG degli indici dei pacchetti? GPG "
read sure
if [[ $sure = "s" ]]
	then
		touch err						
		sudo apt-get update 2>err
 		num=$(grep 'NO_PUBKEY' err | wc -l)	
		str=$(grep 'NO_PUBKEY'  err) 		
		tot=$num
		if [ $num != 0 ]			
			then
			echo "---RISOLVO NO_PUBKEY---"
			for (( i=0 ; i<$num ; i++ ))  	  
				do
				tmp=${str#*NO_PUBKEY }
				key=${tmp:0:16}
				str=${str#*NO_PUBKEY}
				echo "Aggiungo la chiave:$key"
				gpg --keyserver subkeys.pgp.net --recv $key			
				gpg --export --armor $key | sudo apt-key add -		
				done
		fi
	num=0
	num=$(grep 'BADSIG' err | wc -l)	
	str=$(grep 'BADSIG'  err) 		
	tot=$(( $tot + $num ))
	if [ $num != 0 ]			
		then
			echo "---RISOLVO BADSIG---"
			for (( i=0 ; i<$num ; i++ ))  	  
				do
				tmp=${str#*BADSIG }
				key=${tmp:0:16}
				str=${str#*BADSIG}
				echo "Aggiungo la chiave:$key"
				gpg --keyserver subkeys.pgp.net --recv $key			
				gpg --export --armor $key | sudo apt-key add -		
				done
	fi
	rm err					
	else 
		echo "* Aggiornamento chiavi GPG degli indici dei pacchetti...[NON ESEGUITO]"
fi
echo
echo -n "# Aggiorno i pacchetti? Upgrade "
read sure 
if [[ $sure = "s" ]]
	then
		sudo apt-get upgrade
		echo "* Aggiornamento pacchetti...[OK]"
	else 
		echo "* Aggiornamento pacchetti...[NON ESEGUITO]"
fi
echo
echo -n "# Aggiorno la data e l'ora del sistema? NTPDate "
read sure
if [[ $sure = "s" ]]
	then
		sudo ntpdate it.pool.ntp.org
		echo "* Aggiornamento data e ora...[OK]"
	else
		echo "* Aggiornamento data e ora...[NON ESEGUITO]"
fi

echo
echo -n "# Verifico che non ci siano pacchetti difettosi? Install -F "
read sure
if [[ $sure = "s" ]]
	then
        sudo apt-get check
		sudo apt-get install -f
		echo "* Verifica pacchetti difettosi...[OK]"
	else
		echo "* Verifica pacchetti difettosi...[NON ESEGUITO]"
fi
echo
echo "ATTENZIONE: COMANDO POTENZIALMENTE PERICOLOSO!!"
echo -n "# Aggiorno le configurazioni di GRUB? Update - Grub "
read sure
if [[ $sure = "s" ]]
	then
		sudo cp /boot/grub/grub.cfg /boot/grub/grub.cfg.bak
		echo "* Backup /boot/grub/grub.cfg...[OK]"
		sudo update-grub
		echo "* Aggiornamento GRUB...[OK]"
	else 
		echo "* Aggiornamento GRUB...[NON ESEGUITO]"
fi
echo
echo "--------------------------- AGGIORNAMENTO TERMINATO --------------------------"
echo
}

#------------------------------------------------------------------------------------------+
# Programma principale                                                                     |
#------------------------------------------------------------------------------------------+
echo "+============================================================================+"
echo "|               INSTALLAZIONE SOFTWARE E PULIZIA UBUNTU                      |"
echo "+============================================================================+"
echo
echo -n "~~~ ESEGUIRE I COMANDI PER L'AGGIORNAMENTO DEL SISTEMA? "
read sure
if [[ $sure = "s" ]]
	then
		aggiornamento
	else 
		echo "*** Aggiornamento del sistema...[NON ESEGUITO]"
fi

echo
echo -n "~~~ Installo codec e plugin? "
read sure
if [[ $sure = "s" ]]
	then
		codec
	else 
		echo "*** Clodec e plugin non installati"
fi

echo
echo -n "~~~ Installo i software preferiti? "
read sure
if [[ $sure = "s" ]]
	then
		softpreferiti
	else 
		echo "*** Software preferiti non installati"
fi
echo
echo -n "~~~ Installo i software con repository esterni? "
read sure
if [[ $sure = "s" ]]
	then
		softesterni
	else 
		echo "*** Software con repository esterni non installati"
fi

echo
echo -n "~~~ Rimuovo i software non utilizzati? "
read sure
if [[ $sure = "s" ]]
	then
		softremove
	else 
		echo "*** Software non rimossi"
fi

echo
echo -n "~~~ Effettuo una pulizia del sistema?" 
read sure
if [[ $sure = "s" ]]
	then
		pulizia
	else 
		echo "*** Pulizia non riuscita"
fi
echo
echo -n "~~~ E' CONSIGLIABILE RIAVVIARE IL SISTEMA. RIAVVIARE? "
read sure
if [[ $sure = "s" ]]
	then
		sudo reboot
	else 
		echo "*** Riavvio del sistema...[NON ESEGUITO]"
fi
echo
read -p "Premi <INVIO> per uscire"  
