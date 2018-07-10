#!/bin/bash
PROGRAM=$(basename $0)
frequence=60.00

usage() {
    cat <<EOT
    Usage: $PROGRAM OPTIONS <-l 1920 | --hauteur 1080>
        One of the following commands are required:
      * -l|--largeur <largeur>   : la nouvelle largeur en pixels
      * -h|--hauteur <hauteur> : la nouvelle hauteur en pixels
        And any combination of the following OPTIONS are optional:
        -f|--frequence <frequence> : par defaut a 60.00, ne pas oublier le .00
    * Required
EOT
    exit 3
}

while true; do
  case "$1" in
    -l | --largeur ) largeur="$2"; shift ;shift ;;
    -h | --hauteur ) hauteur="$2"; shift ;shift ;;
    -f | --frequence ) frequence="$2"; shift ;shift ;;
	--help ) usage; break ;;
    -- ) shift; break ;;
    * ) [[ ! -z "$1" ]] && usage;break ;;
  esac
done

if [ -z "$largeur" ]; then
	echo "You must put -l for largeur. See --help for help"  >&2 
	exit 1
fi
if [ -z "$hauteur" ]; then
	echo "You must put -h for hauteur. See --help for help" >&2	
	exit 1
fi
if [ -z "$frequence" ]; then
	frequence=60.00
fi

re='^[0-9]+$'
if ! [[ $largeur =~ $re ]] ; then
   echo "error: largeur is not a number, it's $largeur" >&2; exit 1
fi
if ! [[ $hauteur =~ $re ]] ; then
   echo "error: hauteur is not a number, it's $hauteur" >&2; exit 1
fi



res=$(cvt $largeur $hauteur | grep 'Modeline' | sed 's/^\(Modeline \)*//' | sed 's/\"//g')
output=$(xrandr | grep 'primary' | awk -F '\\ connected' '{print $1}')


xrandr --newmode $res
xrandr --addmode $output ${largeur}x${hauteur}_$frequence
xrandr --output $output --mode ${largeur}x${hauteur}_$frequence

