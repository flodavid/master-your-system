# 'xbindkeys --key' or 'xbindkeys --multikey' to know what keys you press
# Put one of the two lines of output of the key association you choosed
# in this file.

# The format of a command line is:
#    "command to start"		# Command
#       associated key		#Keyboard shortcut

# List of modifier:
#   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
#   Mod3 (CapsLock), Mod4 (Super), Mod5 (Scroll).

# More details in ~/.xbindkeysrc

echo "Installation de xbindkeys, permettant l'ajout de raccourcis"
sudo apt-get install xbindkeys

echo "Création d'un fichier de configuration de raccourcis"
touch ~/.xbindkeysrc

# Remplissage initial du fichier
echo -e "\"konsole\"\n  control+Mod1 + t" >> ~/.xbindkeysrc

echo "Ajout des raccourcis"
echo -e "###########################
# xbindkeys configuration #
###########################
#
# Version: 0.1
#
# 'xbindkeys --key' or 'xbindkeys --multikey' to know what keys you press
# Put one of the two lines of output of the key association you choosed
# in this file.

# The format of a command line is:
#    \"command to start\"		# Command
#       associated key		#Keyboard shortcut

# List of modifier:
#   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
#   Mod3 (CapsLock), Mod4 (Super), Mod5 (Scroll).

# A list of keys is in /usr/include/X11/keysym.h and in
# /usr/include/X11/keysymdef.h
# The XK_ is not needed.
#
# List of modifier:
#   Release, Control, Shift, Mod1 (Alt), Mod2 (NumLock),
#   Mod3 (CapsLock), Mod4, Mod5 (Scroll).

# The release modifier is not a standard X modifier, but you can
# use it if you want to catch release events instead of press events

# By defaults, xbindkeys does not pay attention with the modifiers
# NumLock, CapsLock and ScrollLock.
# Uncomment the lines above if you want to pay attention to them.

#keystate_numlock = enable
#keystate_capslock = enable
#keystate_scrolllock= enable

# Examples of commands:" > ~/.xbindkeysrc

echo "Konsole avec Ctrl + Alt + T"
echo -e "\"konsole\"\n  control+Mod1 + t" >> ~/.xbindkeysrc
echo "Dolphin avec Super + E"
echo -e "\"dolphin\"\n  Mod + e" >> ~/.xbindkeysrc

echo "(Rechargement des raccourcis)"
xbindkeys --file ~/.xbindkeysrc

