#!/usr/bin/env bash

# ---------------------------------CREDITS-------------------------------------
# Actual Creators:
#   author_1        :   Lukasz Hryniuk 
#   Code            :   Git user menu part of the code 
#   Original Code   :   https://github.com/hryniuk/rofi-notes/blob/master/rofi_notes.sh 

#   author_2        :   Miroslav Vidovic 
#   Code            :   Repo Cloner part of the code
#   Original Code   :   https://github.com/miroslavvidovic/rofi-scripts/blob/master/github-repos.sh 
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Info:
# Modifications by me : Joined the codes of the above mentioned authors 
#                       for an additional feature for the repo cloner. Added 
#                       some comments.
# Additional Feature  : Asks for git username and also stores them for later use.
#  
# Description:
#   Display all repositories connected with a GitHub user account in rofi and
#   clone the selected repository to current dir by default in home dir, if run 
#   this script from terminal then clones in the current dir.
# -----------------------------------------------------------------------------


#                                                               {S C R I P T}


# variable to store selected git username
GITUSR=""

# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  GIT USER MENU  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

set -u
set -e

# file to store git usernames so as to reuse again,
readonly USERNAMES=~/ROFI/MY-PLUGS/Git-Plugin/.usrnames

# get all the text from the .username file
function get_users()
{
    # print out the files contents
    cat ${USERNAMES}
}

# function to add new username to menu list
function add_to_menu()
{
    # store all text in the txt file in the variable
    local all_users="$(get_users)" 

    # ask for user input
    local USER="$( (echo "${all_users}") | rofi  -dmenu -p "Git UserName" )"

    # checking if the the new username entered already exist in the file or not, 
    # and if exists then store it in the variable
    local matching=$( (echo "${all_users}") | grep "^${USER}$")

    # -n: not empty string
    # if "matching" has any value in it or in other words "is not empty",
    # then dont add the new username entered and store the previous contents of the file 
    if [[ -n "${matching}" ]]; then
        local new_users=$( (echo "${all_users}"))

    # if "matching" has no value in it or in other words "is empty",
    # then concatenate the new username with the previous contents of the file 
    else    
        local new_users=$( (echo -e "${all_users}\n${USER}") | grep -v "^$")
    fi

    # finally replace the file contents with the data in the "new_users" variable
    echo "${new_users}" > "${USERNAMES}"

    # store the selected/entered username in the global variable "GITUSR"
    GITUSR=$USER
}
add_to_menu #fuction call


# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░  REPO CLONER  ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
# ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░

# GitHub user account URL
URL="https://github.com/$GITUSR/"

# Clone a repository into the current/by default in (~)home directory
clone_repository(){

  local repository=$1
  if [ -z "$repository" ]; then
    echo "ERROR: You need to enter the name of the repository you wish to clone."
  else
    git clone "$URL$repository"
  fi
}

# Get all the repositories for the user with curl and GitHub API and filter only
# the repository name from the output with sed substitution
all_my_repositories_short_name(){
  curl -s "https://api.github.com/users/$GITUSR/repos?per_page=1000" | grep -o 'git@[^"]*' |\
    sed "s/git@github.com:$GITUSR\///g"
}

# Rofi dmenu
rofi_dmenu(){
  rofi -dmenu -matching fuzzy -no-custom -p "Select a repository"\
    -location 0 -bg "#F8F8FF" -fg "#000000" -hlbg "#ECECEC" -hlfg "#0366d6"
}

main(){
  repository=$(all_my_repositories_short_name | rofi_dmenu )
  clone_repository "$repository"
}

main #fuction call
  
exit 0
