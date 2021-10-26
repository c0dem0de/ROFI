#! /bin/bash

# ---------------------------------CREDITS-------------------------------------
# Actual Creators:
#   author_1        :   c0dem0de
#   Code            :   All parts of the code 
#   Original Code   :   https://github.com/c0dem0de/ROFI/MAIN-MENU.sh  
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Info:
#  
# Description:
#   Main Menu Linking to all Plugins of rofi.
# -----------------------------------------------------------------------------


#                                                               {S C R I P T}


OPTIONS="\
Applets
Files
Calculator
Emoji
Web-Surf
GitRepo-Clone
Edit Rofi and Plugin config/code Files
"

MENU=$(echo "$OPTIONS" | rofi -dmenu -p "ROFI-MENU")




if [ "$MENU" = "Applets" ]
then
        rofi -show drun

elif [ "$MENU" = "Files" ]
then
        sh -c 'xdg-open "$(find * | rofi -threads 0 -dmenu -i -p "locate")"'

elif [ "$MENU" = "Calculator" ]
then
        sh -c 'rofi -show calc -modi calc -no-show-match -no-sort'

elif [ "$MENU" = "Emoji" ]
then
        rofi -show emoji

elif [ "$MENU" = "Web-Surf" ]
then
        sh -c '~/ROFI/MY-PLUGS/WebSearch-Plugin/web-search.sh'

elif [ "$MENU" = "GitRepo-Clone" ]
then
        sh -c '~/ROFI/MY-PLUGS/Git-Plugin/clone-repo.sh'

elif [ "$MENU" = "Edit Rofi and Plugin config/code Files" ]
then
        sh -c '~/ROFI/MY-PLUGS/ConfigFiles-Plugin/configfiles.sh'

fi
