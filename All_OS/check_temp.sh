#!/bin/bash

dir=$HOME/.script_cpu_temp

help=" Script pour créer un graphe des températures du CPU.\n Les arguments sont : \n -h | --help : Affiche l'aide \n -l | --launch : Lance le programme \n -r | --reset : Reset les fichiers du programme \n -d | --destroy : Détruit les traces du fichier"

function launch()
{
    if [ ! -d "$dir" ];then
        mkdir $dir;
        echo -e "{\n\t\"datas\":[\n\t]\n}"> $dir/data; 
        chmod 755 $dir/data; 
    fi
    sed -i '$ d' $dir/data; 
    sed -i '$ d' $dir/data; 
    temp=$(cat /sys/devices/virtual/thermal/thermal_zone0/temp);
    date=`date '+%Y %m %d %H %M %S'`
    echo -e "\t\t{\"date\":\"$date\",\"temp\":\"$temp\"}," >> $dir/data
    echo -e "\n\t{}]\n}" >> $dir/data
}

while true; do
  case "$1" in
    -h | --help ) echo -e $help;exit; break ;;
    -l | --launch ) launch; break ;;
    -r | --reset ) rm $dir/*; break ;;
    -d | --destroy ) rm -R $dir ; break ;;
    * ) echo -e $help ; exit; break ;;
  esac
done

