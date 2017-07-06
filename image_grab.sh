#!/bin/bash

#Because Craigslist uses Javascript to display images, a simple wget command to get the pictures will not work.


#Get all posted items for sale
mkdir $(uuid) && cd $_ && wget -w 3 --level=1 -nd -rkH -e robots=off -A .html https://orangecounty.craigslist.org/search/rea

#Parses each file and extracts the url link to the picture (if there are any) and dumps it into LIST
grep -h -r -e '(?<=\"url\"\:\")(https.*?\.jpg)' -oP * >> ../LIST

#Downloads the image from LIST
cd .. && mkdir "$(uuid)_pictures" && cd $_ && wget -i ../LIST
