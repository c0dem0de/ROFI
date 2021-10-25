#! /bin/bash

# ---------------------------------CREDITS-------------------------------------
# Actual Creators:
#   author_1        :   c0dem0de
#   Code            :   All parts of the code 
#   Original Code   :   https://github.com/c0dem0de/ROFI/MY-PLUGS/ConfigFiles-Plugin/configfiles.sh 
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Info:
#  
# Description:
#   Opens config files for rofi and plugins.
# -----------------------------------------------------------------------------


#                                                               {S C R I P T}


OPTIONS="\
Rofi Config
Rofi Theme
Websearch Code
Gitrepo Code
"

CONFIGS=$(echo "$OPTIONS" | rofi -dmenu -p "Configs")




if [ "$CONFIGS" = "Rofi Config" ]
then
        gedit ~/.config/rofi/config.rasi

elif [ "$CONFIGS" = "Rofi Theme" ]
then
        gedit /usr/share/rofi/themes/c0dem0de-dark.rasi

elif [ "$CONFIGS" = "Websearch Code" ]
then
        gedit ~/ROFI/MY-PLUGS/WebSearch-Plugin/web-search.sh

elif [ "$CONFIGS" = "Gitrepo Code" ]
then
        gedit ~/ROFI/MY-PLUGS/Git-Plugin/clone-repo.sh

fi
