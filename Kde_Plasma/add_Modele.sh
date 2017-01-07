#!/bin/bash

Modele_folder_name=Modèles

Modele_folder=~/$Modele_folder_name
ln -s $Modele_folder

#Simple script file
touch ./Modèles/Simple_bash_script.txt
echo -e "#!/bin/bash \n" >> ./Modèles/Simple_bash_script.txt

#Simple odt
touch ./Modèles/Simple_ODT.txt
soffice --convert-to odt ./Modèles/Simple_ODT.txt  --headless
mv ./Simple_ODT.odt ./Modèles/Simple_ODT.odt
rm ./Modèles/Simple_ODT.txt


rm -i ./$Modele_folder_name
