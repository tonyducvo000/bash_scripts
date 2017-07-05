#!/bin/bash

#Because CL uses JS to display images, simple wget command to get the files will not work

#Get all posted items for sale
wget -w 3 --level=1 -nd -rkH -e robots=off -A .html https://orangecounty.craigslist.org/search/rea

#Parses each file and extracts the url link to the picture (if there is any) and dumps it into pictures.txt
grep -h -r -e '(?<=content\=\")(https.*\.jpg)' -oP * >> pictures.txt

#Downloads the image from the list pictures.txt
wget -i pictures.txt
