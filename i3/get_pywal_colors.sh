#!/bin/bash

# Read the contents of the script into a variable
file_contents=$(<~/.cache/wal/colors.sh)

# Use grep to extract color variables and assign them to corresponding variables
export background=$(echo "$file_contents" | grep -oP '(?<=background='\'').*?(?='\'')')
export foreground=$(echo "$file_contents" | grep -oP '(?<=foreground='\'').*?(?='\'')')
export cursor=$(echo "$file_contents" | grep -oP '(?<=cursor='\'').*?(?='\'')')

export color0=$(echo "$file_contents" | grep -oP '(?<=color0='\'').*?(?='\'')')
export color1=$(echo "$file_contents" | grep -oP '(?<=color1='\'').*?(?='\'')')
export color2=$(echo "$file_contents" | grep -oP '(?<=color2='\'').*?(?='\'')')
export color3=$(echo "$file_contents" | grep -oP '(?<=color3='\'').*?(?='\'')')
export color4=$(echo "$file_contents" | grep -oP '(?<=color4='\'').*?(?='\'')')
export color5=$(echo "$file_contents" | grep -oP '(?<=color5='\'').*?(?='\'')')
export color6=$(echo "$file_contents" | grep -oP '(?<=color6='\'').*?(?='\'')')
export color7=$(echo "$file_contents" | grep -oP '(?<=color7='\'').*?(?='\'')')
export color8=$(echo "$file_contents" | grep -oP '(?<=color8='\'').*?(?='\'')')
export color9=$(echo "$file_contents" | grep -oP '(?<=color9='\'').*?(?='\'')')
export color10=$(echo "$file_contents" | grep -oP '(?<=color10='\'').*?(?='\'')')
export color11=$(echo "$file_contents" | grep -oP '(?<=color11='\'').*?(?='\'')')
export color12=$(echo "$file_contents" | grep -oP '(?<=color12='\'').*?(?='\'')')
export color13=$(echo "$file_contents" | grep -oP '(?<=color13='\'').*?(?='\'')')
export color14=$(echo "$file_contents" | grep -oP '(?<=color14='\'').*?(?='\'')')
export color15=$(echo "$file_contents" | grep -oP '(?<=color15='\'').*?(?='\'')')
