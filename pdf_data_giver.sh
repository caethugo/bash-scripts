#!/bin/bash
folder=/Users/hugocaetano/Desktop/cheat_sheets_cours

#The -lS option gives us the list of files in descending size order with extra not needed information. 
#Then, we extract only the file within the pipe
for file in $(ls -lS $folder/*.pdf $folder/*/*.pdf | awk '{ print $9 }' | tail -n +2) 
do
  echo $file | sed 's:.*/::'
  echo "Location : $file"
  echo -n "Number of pages : "; pdftk $file dump_data | grep NumberOfPages | awk '{print $2}'
done
