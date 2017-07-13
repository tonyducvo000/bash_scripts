#!/bin/bash

function pause(){
	read -p "$*"
}

if !(echo $1 | grep -E '[a-zA-Z]*\.*\.craigslist\.org|com.*')  ; then
		echo -e "Invalid address! Your URL address must be a Craigslist address!\n";	
		exit 1;
fi		



mkdir $(echo $(date +%Y-%m-%d)"_capture") && cd $_
#Because CL uses JS to display images, simple wget command to get the files will not work
html=$(echo $(uuid)"_html")
pics=$(echo $(uuid)"_pictures")

#Get all posted items for sale
mkdir $html && cd $_ && wget -w 3 --level=1 -nd -rkH -e robots=off -A .html $1

#Parses each file and extracts the url link to the picture (if there is any) and dumps it into LIST
grep -h -r -e '(?<=\"url\"\:\")(https.*?\.jpg)' -oP * >> ../LIST

#Downloads the image from LIST
cd .. && mkdir $pics && cd $_ && wget -i ../LIST

exit 0
