#!/usr/bin/env bash

# ---------------------------------CREDITS-------------------------------------
# Actual Creators:
#   author_1        :   Lukasz Hryniuk 
#   Code            :   All parts of the code 
#   Original Code   :   https://github.com/miroslavvidovic/rofi-scripts/blob/master/web-search.sh  
# -----------------------------------------------------------------------------
# -----------------------------------------------------------------------------
# Info:
# Modifications by me : Written code to ask for browser of choice. Added some comments
# Additional Feature  : Asks for browser of choice
#  
# Description:
#   Use rofi to surf the web.
# -----------------------------------------------------------------------------


                                                                #{S C R I P T}

# terminal cmds
  # Normal Browsing
    # firefox "https://duckduckgo.com/?q=what is linux"
    # brave "https://duckduckgo.com/?q=what is linux"
  # Private Browsing
    # firefox -private-window "https://duckduckgo.com/?q=what is linux"   -- firefox private mode
    # brave --incognito "https://duckduckgo.com/?q=what is linux"         -- brave private mode
    # brave --incognito --tor "https://duckduckgo.com/?q=what is linux"   -- brave private +tor mode


# creating a new variable "URLS"
declare -A URLS

# List of all visitable urls, more can be added
URLS=(

#  name of url  =  url of the site
  ["duckduckgo"]="https://www.duckduckgo.com/?q="
  ["google"]="https://www.google.com/search?q="
  ["youtube"]="https://www.youtube.com/results?search_query="
  ["askubuntu"]="http://askubuntu.com/search?q="
  ["stackoverflow"]="http://stackoverflow.com/search?q="

)

BROWSERS="\
FireFox
FireFox (private)
Brave
Brave (private)
Brave (private+tor)
"

# Get items from the array one by one
gen_list() {
    for i in "${!URLS[@]}"
    do
      echo "$i"
    done
}

main() {
  # Pass the list to rofi, display items in the rofi menu
  platform=$( (gen_list) | rofi -dmenu -matching fuzzy -no-custom -location 0 -p "Search" )

  # -n: not empty string
  # if the variable "platform" has some value or in other words 'is not empty',
  # then ask for a search query.
  if [[ -n "$platform" ]]; then
    # rofi text field to enter query
    query=$( (echo ) | rofi  -dmenu -matching fuzzy -location 0 -p "Query" )

    # if the variable "query" has some value or in other words 'is not empty',
    # then ask for browser of choice.
    if [[ -n "$query" ]]; then
      url=${URLS[$platform]}$query      

      # opens the url in the default browser,
      # uncomment this line and comment the other line realted to browser
      # to stop for an other promt by rofi for browser select. 
      # xdg-open "$url"

      # rofi browser menu to take input for browser of choice
      browser=$( (echo "$BROWSERS") | rofi  -dmenu -matching fuzzy -location 0 -p "Browser" )
      # if the variable "browser" has some value or in other words 'is not empty',
      # then open the selected web site with the inputted search query according
      # to the conditions for diff browsers.

      #ask for a search query
      if [[ -n "$browser" ]]; then
        if [ "$browser" = "FireFox" ]; then
          firefox "$url"

        elif [ "$browser" = "FireFox (private)" ]; then
          firefox -private-window "$url"

        elif [ "$browser" = "Brave" ]; then
          brave "$url"

        elif [ "$browser" = "Brave (private)" ]; then
          brave --incognito "$url"

        elif [ "$browser" = "Brave (private+tor)" ]; then
          brave --incognito --tor "$url"
        
        # if there is no condition for the selected browser type
        # or the blank option after the "Brave (private+tor)" option
        # is selected then close rofi menu.
        else  
          exit
        fi
      
      # if "browser" has no value or in other words 'is empty',
      # then close rofi menu.
      else  
        exit    
      fi

    # if "query" has no value or in other words 'is empty',
    # then close rofi menu.
    else
      exit
    fi

  # if "platform" has no value or in other words 'is empty',
  # then close rofi menu
  else  
    exit
  fi
}

main #finction call

exit 0

# -----------------------------------------------------------------------------
# Removed URLS by me:
  # ["bing"]="https://www.bing.com/search?q="
  # ["yahoo"]="https://search.yahoo.com/search?p="
  # ["yandex"]="https://yandex.ru/yandsearch?text="
  # ["goodreads"]="https://www.goodreads.com/search?q="
  # ["symbolhound"]="http://symbolhound.com/?q="
  # ["superuser"]="http://superuser.com/search?q="
  # ["imdb"]="http://www.imdb.com/find?ref_=nv_sr_fn&q="
  # ["rottentomatoes"]="https://www.rottentomatoes.com/search/?search="
  # ["piratebay"]="https://thepiratebay.org/search/"
  # ["github"]="https://github.com/search?q="
  # ["searchcode"]="https://searchcode.com/?q="
  # ["openhub (opensource apps)"]="https://www.openhub.net/p?ref=homepage&query="
  # ["vimawesome"]="http://vimawesome.com/?q="
# -----------------------------------------------------------------------------
