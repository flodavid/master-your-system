#!/bin/bash

DIR=$HOME/.script_cpu_temp
FILENAME=$DIR/data
MAX_LINES=100000
MIN_LINES=4
MAX_SECONDS=1
MIN_SECONDS=0

help=" Script pour créer un graphe des températures du CPU.\n Les arguments sont : \n -m || --max : Définit la taille max du fichier, avec un minimum de 4 lignes. Raccourci le fichier si plus grand. Par défaut 100.000 lignes\n -s | --seconds : Définit le nombre de secondes durant laquelle il va vérifier \n -h | --help : Affiche l'aide \n -l | --launch : Lance le programme \n -r | --reset : Reset les fichiers du programme \n -d | --destroy : Détruit les traces du fichier"

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
    
   
    
    
    LINES=$(($(wc -l < $FILENAME) - 3));
   
    while [ $LINES -gt $MAX_LINES ]
    do
        sed -i '3d' $FILENAME;
        LINES=$(wc -l < $FILENAME);
    done
    
    temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp);
    i=1
    while [ $MAX_SECONDS -gt 0 ]
    do
        i=$(($i + 1));
        sleep 1;
        MAX_SECONDS=$(($MAX_SECONDS - 1));
        temp=$(($temp+$(cat /sys/devices/virtual/thermal/thermal_zone0/temp)));
    done
    
    temp=$(($temp / $i));
    date=`date '+%Y %m %d %H %M %S'`
    sed -i '/^$/d' $FILENAME
    sed -i '$ d' $FILENAME; 
    sed -i '$ d' $FILENAME; 
    echo -e "\t\t{\"date\":\"$date\",\"temp\":\"$temp\"}," >> $FILENAME
    echo -e "\n\t{}]\n}" >> $FILENAME
    sed -i '/^$/d' $FILENAME
}

while true; do
  case "$1" in
    -m | --max ) MAX_LINES=$2; if [ $MAX_LINES -lt $MIN_LINES ];then echo "Trop petit, taille minimum de 4 lignes. La taille max a été modifiée à 4 lignes" ; MAX_LINES=$MIN_LINES ; fi ; shift 2;; 
    -s | --seconds ) MAX_SECONDS=$2; if [ $MAX_SECONDS -lt $MIN_SECONDS ];then echo "Le nombre de secondes doit être positif, je remet à 0 seconde" ; MAX_SECONDS=$MIN_SECONDS ; fi ; shift 2;; 
    -h | --help ) echo -e $help;exit; break ;;
    -l | --launch ) launch; break ;;
    -r | --reset ) rm $FILENAME;reset; break ;;
    -d | --destroy ) rm -R $DIR ; break ;;
    * ) echo -e $help ; exit; break ;;
  esac
done

