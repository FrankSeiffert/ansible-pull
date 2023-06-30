#!/bin/bash

printf "" > /tmp/java-$(hostname).txt

for f in $(sudo find / -xdev -name java -type f ! -size 0 -exec grep -IL . "{}" \;); do
  printf "java;" >> /tmp/java-$(hostname).txt
  dirname $f | tr -d "\n" >> /tmp/java-$(hostname).txt
  printf ";" >> /tmp/java-$(hostname).txt
  $f -version 2> /tmp/java-$(hostname)-binary.txt
  grep -m1 -i version /tmp/java-$(hostname)-binary.txt | sed 's/.*"\(.*\)".*/\1/g' | tr -d "\n" >> /tmp/java-$(hostname).txt
  
  sed -i '/version/d' /tmp/java-$(hostname)-binary.txt 
  sed -i '/Server/d' /tmp/java-$(hostname)-binary.txt 
  cat /tmp/java-$(hostname)-binary.txt | tr -d "\n" >> /tmp/java-$(hostname).txt
  
  echo ";NTS\\"$(id -un) >> /tmp/java-$(hostname).txt
done


