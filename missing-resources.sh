#!/bin/sh
echo "<html>"
echo "<h1>STEP 1</h1>"
echo "<h2> Missing resources </h2>"

#pliki do wyszukiwania
files=`find $1 -name '*.[mh]' -or -name '*.storyboard'`
project=`find $1 -name '*.pbxproj'`
unusedfiles=""
count=0

#echo $project

for file in $files; do 
	#echo $file
	for img in `grep -o '\"[^"]*png\"' $file | sed 's/\"//g'`; do
		#echo $img			
		NUM=$(find $1 -name "$img" | wc -l)
		if [ "$NUM" -ne 1 ]  ; then
			#line=`grep $img $project`
			#echo $line
        	unusedfiles="$unusedfiles <br> $img in file <a href=\"$file\">$file</a> <br>";
	        let "count = count + 1";
    	fi
	done
done

#thats it!
echo "<pre>"
#generate body content if there are unused files.
if [ $count > 0 ]; then
    echo $unusedfiles;
fi
echo "</pre>"
echo "</body>"
echo "</html>"