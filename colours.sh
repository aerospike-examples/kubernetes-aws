#!/bin/bash

#Background
for clbg in $(seq 40 47) $(seq 100 107) 49 ; do
#Foreground
for clfg in $(seq 30 37) $(seq 90 97) 39 ; do
#Formatting
for attr in 0 1 2 4 5 7 ; do
#Print the result
printf "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
done
echo #Newline
done
done
