#!/bin/bash

######################
#       Colors       #
######################

greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

######################
#  Function CTRL +C  #
######################

function ctrl_c(){
    trap ctrl_c INT
    echo -e "\n${yellowColour}[]${endColour}${grayColour}Leaving${endColour}"
    exit 0
}
#####################
#       Banner      #
#####################
echo -e "${redColour}    ____________    ____  ___________"
sleep 0.05
echo -e "   / ____/  _/ /   / __ \/ ____/ ___/"
sleep 0.05
echo -e "  / /_   / // /   / / / / / __ \__ \\"
sleep 0.05
echo -e " / __/ _/ // /___/ /_/ / /_/ /___/ /"
sleep 0.05
echo -e "/_/   /___/_____/\____/\____//____/  ${endColour}"
echo -e "${blueColour} By Erik451 ${endColour}"
#####################
#      Options      #
#####################

echo -e "\n ${yellowColour}Available Filters: ${endColour}"

echo -e "\n 1) ${grayColour}List the ips ${endColour}   3) ${grayColour}Filter by status code${endColour}"

echo -e "\n 2) ${grayColour}Filtered by ip${endColour}  4) ${grayColour}Shows only the requests${endColour}"

# More options soon...

######################
#   Variable value   #
######################
printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Logs File: ${endColour}"; read file
printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Option: ${endColour}"; read option

######################
#      Funtions      #
######################

# List the ips
List(){
    cat "$file"|awk '{print $1}'|sort -u
}

# Filtered by ip
Ip(){
    printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Ip: ${endColour}"; read ip
    cat "$file"|grep "$ip"
}

# Filter by status code
Status(){
    printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Status code: ${endColour}"; read code
    awk '$9 ~ /'$code'/ {print}' "$file"
}

# Show only requests
Request(){
    awk '{count[$7]++}; END { for (i in count) print i}' "$file"
}
######################
#   Select function  #
######################
case $option in

    1)
        List
         ;;
    2)
        Ip
         ;;
    3)
        Status
         ;;
    4)
        Request
         ;;
esac
