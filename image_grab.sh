#!/bin/bash


help(){
	echo -e "\tHELP MENU:\n\n"
	echo -e "\t-r removes http directory"
	echo -e "\n\tExample usage:\n\t./image_grab.sh -r mylocation.craigslist.org/search/msa\n\n"
	exit 0;
}

last="${@: -1}"

TEST=$(curl -o /dev/null --silent --head --write-out '%{http_code}\n' $last)

if [ $# -eq 0 ] ; then
	help
fi

if [ $# -eq 1 ] ; then
	if ! curl --output /dev/null --silent --head --fail $last  ; then
			 echo -e "Could not find name or service...\n"
			 exit 1
	else if curl --output /dev/null --silent --head --fail $last  ; then
		   mkdir $(echo $(date +%Y-%m-%d)"_capture") && cd $_
		   html=$(echo $(uuid)"_html")
		   pics=$(echo $(uuid)"_pictures")
		   mkdir $html && cd $_
		   echo -e "Valid craigslist URL!  Downloading...\n"
			 wget -o ..output.log -w 3 -level=1 -nd -rkH -e robots=off -A .html $last
			 grep -h -r -e '(?<=\"url\"\:\")(https.*?\.jpg)' -oP * >> ../LIST
			 cd .. && mkdir $pics && cd $_ && wget -i ../LIST
			 echo -e "\n\n\n\t\tDownload complete!"
			 exit 0
		 fi
	fi
fi

mkdir $(echo $(date +%Y-%m-%d)"_capture") && cd $_
html=$(echo $(uuid)"_html")
pics=$(echo $(uuid)"_pictures")
mkdir $html && cd $_

#Parses each file and extracts the url link to the picture (if there is any) and dumps it into LIST
#Downloads the image from LIST

while getopts ":lr" options; do
	case $options in
		r) 			wget -o ../output.log -w 3 --level=1 -nd -rkH -e robots=off -A .html $last
						grep -h -r -e '(?<=\"url\"\:\")(https.*?\.jpg)' -oP * >> ../LIST
						cd .. && mkdir $pics && cd $_ && wget -i ../LIST
						cd .. && rm -rf $html;;
		*) echo "Please enter a valid option!" && exit 1;;
	esac
done

echo -e "\n\n\n\t\tDownload complete!"

exit 0
