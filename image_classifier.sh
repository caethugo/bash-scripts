#!/bin/bash

#Exporting metadata

exiftool -r -common -ext .JPG -ext .jpeg ./ > Desktop/folder/metest.txt 

#Moving files in new directory then renaming them YYYY_MM_DD_HH_MM_n
#It was done in many steps because I was quite struggling on having a good regex

mkdir ~/Desktop/photoland #no error if exists
mv ~/Desktop/photoset/*.JPG ~/Desktop/photoland #no error if none

for filename in ~/Desktop/photoland/*
do
  filedate=$(exiftool -T -DateTimeOriginal "$filename")
  inter_s=${filedate// /$'_'}
  string=${inter_s//:/$'_'}
  final_name=${string:0:16} 
  mv  "$filename" ~/Desktop/photoland/$final_name.JPG
done 

#Now we'll want to classify those pictures in directories, sending 2022_09_10_13-05 to ./2022/09/10/13_05 for instance. 

for filename in ~/Desktop/photoland/*
do
  pre_fo=${filename/$'_'/$'/'} #getting folder path
  pre_fo=${pre_fo/$'_'/$'/'} #I didn't know how to substitute all dashes at once
  pre_fo=${pre_fo/$'_'/$'/'}
  pre_fo=${pre_fo/$'_'/$'/'}
  folder=${pre_fo: -20:16} #could have done differently but clearer that way I think
  file=${pre_fo: -6}
  if [[ ! -d $folder ]]
  then
    mkdir -p ~/Desktop/photoland/$folder
    mv $filename ~/Desktop/photoland/$folder/1.JPG
  else 
    N=2
    while [[ -f ~/Desktop/photoland/$folder/$N ]]
    do
      N=N+1
    done
    mv $filename ~/Desktop/photoland/$folder/1.JPG
fi 
done




