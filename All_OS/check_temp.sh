#!/bin/bash

DIR=$HOME/.script_cpu_temp
FILENAME=$DIR/data
MAX_LINES=100000
MIN_LINES=4

help=" Script pour créer un graphe des températures du CPU.\n Les arguments sont : \n -m || --max : Définit la taille max du fichier, avec un minimum de 4 lignes. Raccourci le fichier si plus grand. Par défaut 100.000 lignes \n -h | --help : Affiche l'aide \n -l | --launch : Lance le programme \n -r | --reset : Reset les fichiers du programme \n -d | --destroy : Détruit les traces du fichier"

function reset(){
    mkdir $DIR;
    echo -e "{\n\t\"datas\":[\n\t]\n}"> $FILENAME; 
    chmod 755 $FILENAME; 
}

function launch()
{
    if [ ! -d "$DIR" ];then
        reset
    fi
    
    sed -i '/^$/d' $FILENAME
    
    LINES=$(wc -l < $FILENAME);
   
    while [ $LINES -gt $MAX_LINES ]
    do
        sed -i '3d' $FILENAME;
        LINES=$(wc -l < $FILENAME);
    done
    
    sed -i '$ d' $FILENAME; 
    sed -i '$ d' $FILENAME; 
    temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp);
    date=`date '+%Y %m %d %H %M %S'`
    echo -e "\t\t{\"date\":\"$date\",\"temp\":\"$temp\"}," >> $FILENAME
    echo -e "\n\t{}]\n}" >> $FILENAME
    sed -i '/^$/d' $FILENAME
}

while true; do
  case "$1" in
    -m | --max ) MAX_LINES=$2; if [ $MAX_LINES -lt $MIN_LINES ];then echo "Trop petit, taille minimum de 4 lignes. La taille max a été modifiée à 4 lignes" ; MAX_LINES=$MIN_LINES ; fi ; shift 2;; 
    -h | --help ) echo -e $help;exit; break ;;
    -l | --launch ) launch; break ;;
    -r | --reset ) rm $FILENAME;reset; break ;;
    -d | --destroy ) rm -R $DIR ; break ;;
    * ) echo -e $help ; exit; break ;;
  esac
done

