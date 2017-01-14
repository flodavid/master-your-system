#!/bin/bash

index=0
#toujours mettre l'élément à alliasser, puis ="ce qu'il va faire" 
#exemple : 'testalias' '="echo \"testalias\""'
to_install_rodolphe=('update_grub' '="grub2-mkconfig -o /boot/grub2/grub.cfg"'
'g++-5' '="g++"'
'fuck' '="sudo \$(history -p \!\!)"'
);

echo "To end this, just press e"
while true; do
    if [[ -z ${to_install_rodolphe[$index]} ]]; then
        exit 1
    fi
    read -p "Do you wish to alias ${to_install_rodolphe[$index]} ${to_install_rodolphe[$index+1]} ? (press e to exit)" yne
    case $yne in
        [Yy]* )
        #\ ${to_install_rodolphe[$index]}
        if [[ $(find ~/.bashrc -type f -print | xargs grep alias\ ${to_install_rodolphe[$index]} ) ]]; then
            echo "${to_install_rodolphe[$index]} déjà installé";
        else
            echo "alias ${to_install_rodolphe[$index]}${to_install_rodolphe[$index+1]}" >> ~/.bashrc
            echo "${to_install_rodolphe[$index]} installé";
        fi
        index=$index+2
        ;;
        [Nn]* ) index=$index+2;;
        [Ee]* ) source ~/.bashrc ; exit 1;;
        * ) echo "Please answer yes or no or exit.";;
    esac
done

