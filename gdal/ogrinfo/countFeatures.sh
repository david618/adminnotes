#!/bin/bash

total=0

for file in /Users/davi5017/s3/rtgeonames/countries/shp/*.shp; do
	#echo $file
        cnt=$(ogrinfo -ro -so -al ${file} | grep "^Feature Count" | cut -d ":" -f2 | xargs)
        echo "$(basename ${file}) : ${cnt}"
        total=$((total+cnt))
done

echo "Total Number of Features: ${total}"
