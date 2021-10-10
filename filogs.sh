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
    echo -e "\n${yellowColour}[]${endColour}${grayColour}Saliendo${endColour}"
    exit 0
}
#####################
#       Banner      #
#####################
echo -e "${blueColour}    ____________    ____  ___________"
sleep 0.05
echo -e "   / ____/  _/ /   / __ \/ ____/ ___/"
sleep 0.05
echo -e "  / /_   / // /   / / / / / __ \__ \\"
sleep 0.05
echo -e " / __/ _/ // /___/ /_/ / /_/ /___/ /"
sleep 0.05
echo -e "/_/   /___/_____/\____/\____//____/  ${endColour}"
echo -e "${redColour} by Erik451${endColour}"
#####################
#       Options     #
#####################
echo -e "\n ${purpleColour}Available Filters: ${endColour}"

echo -e "\n 1) ${grayColour}List the ips ${endColour}           4) ${grayColour}Shows only the requests${endColour}"

echo -e "\n 2) ${grayColour}Filtered by ip${endColour}          5) ${grayColour}Show all IP GeoLocations${endColour}"

echo -e "\n 3) ${grayColour}Filter by status code${endColour}   6) ${grayColour}Show a single IP GeoLocation${endColour}"

######################
#   Variable value   #
######################
printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Logs File: ${endColour}"; read file
printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Option: ${endColour}"; read option
######################
#      Funtions      #
######################

# (1) List the ips
List(){
    cat "$file"|awk '{print $1}'|sort -u
}
# (2) Filtered by ip
Ip(){
    printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Ip: ${endColour}"; read ip
    cat "$file"|grep "$ip"
}
# (3) Filter by status code
Status(){
    printf "\n${redColour}[${yellowColour}*${redColour}]${turquoiseColour} Enter the Status code: ${endColour}"; read code
    awk '$9 ~ /'$code'/ {print}' "$file"
}
# (4) Show only requests
Request(){
    awk '{count[$7]++}; END { for (i in count) print i}' "$file"
}

# (6) List Ips location
AllGeo(){
    cat p1.txt|  awk '{print $1}' |sort -u > list.txt
    input="list.txt"
###Gets the infomation of the ips from an API
long=$(wc -l list.txt|awk '{print $1}')
bar="0"
    while IFS= read -r line
    do
        curl "https://ipinfo.io/$line" >> 1.txt &&
        bar=$(($bar + 1))
        clear
        echo "Processing [$bar/${long}]"

    done < "$input"
###Delete a unwanted line
    egrep -v '"readme": "https://ipinfo.io/missingauth"' 1.txt > output.txt
    rm 1.txt list.txt

    printf "Do you want to save? [Y/N]: "; read save
    if [ $save = Y ]; then
        echo 'Saved output.txt'
        exit 0
    else
    if [ $save = N ]; then
        echo 'Deleted output.txt';rm output.txt
    else
        echo "WTF elige Y o N tonto"
    fi
    fi
    exit
}
# (6) Ip location
Geo(){
    printf "${redColour}Enter an IP: ${endColour}"; read iploc
    curl "https://ipinfo.io/$iploc"
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

    5)
        AllGeo
         ;;

    6)
        Geo
         ;;
esac

    
