#!/bin/bash

# Update the system packages DB.
sudo pacman -Syu

# Iterate list of programs to install.
while IFS= read -r -u 3 ENTRY; do

  NAME="$(cut -d ',' -f 1 <<< $ENTRY)"
  CATEGORY="$(cut -d ',' -f 2 <<< $ENTRY)"
  DESCRIPTION="$(cut -d ',' -f 3 <<< $ENTRY)"
  BINDING="$(cut -d ',' -f 4 <<< $ENTRY)"
  TAG="$(cut -d ',' -f 5 <<< $ENTRY)"
  OPTION=""

  while [[ "$OPTION" != "y" ]] && [[ "$OPTION" != "n" ]]; do

    echo "[*] Do you want to install $NAME? (y/n)"
    echo "    Description: $DESCRIPTION"
    read -p "    " -r OPTION

    if [[ "$OPTION" != "y" ]]; then
   
      continue

    elif [[ "$TAG" == "" ]]; then

      sudo pacman -S --noconfirm "$NAME"

    else
      
      yay -S --noconfirm "$NAME"

    fi

  done

done 3<<< "$(tail -n +2 ./static/progs.csv)"
