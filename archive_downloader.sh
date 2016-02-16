## archive.org downloader
## Candan BOLUKBAS

#for i in {1996..2016}; do echo "https://web.archive.org/web/"$i"0101000000*/"$1; done

for link in $(for i in {1996..2016}; 
	do echo "https://web.archive.org/web/"$i"0101000000*/"$1; 
	done); 
do wget "$link" -q -O $(echo $link | grep -o -E "[0-9]+").html; 
#do echo $(echo $link | grep -o -E "[0-9]+").html; 
done

COUNT=$(grep "$1" *.html | grep -v "year-label" | grep -o -E "/web/[a-zA-Z0-9:/\.\_-]+" | sed -E 's/\/$//g' | sort -n | uniq | wc -l )
echo "Number of archive linke: "$COUNT

echo -ne '  '$COUNT"     items left."'\r'

for link in $(for file in *.html; 
	do grep "$1" $file ; 
	done | grep -v "year-label" | grep -o -E "/web/[a-zA-Z0-9:/\.\_-]+" | sed -E 's/\/$//g' | sort -n | uniq | awk '{print "https://web.archive.org"$0"/"}'); 
do wget $link -q -O $(echo $link | grep -o -E "[0-9]+").out; COUNT=$(( COUNT-1 )); echo -ne '   '$COUNT'\r'
done

echo -ne '\n'

for i in {1996..2016}; do rm -rf $i"0101000000.html" || true; done