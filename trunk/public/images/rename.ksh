for file in [a-z]*.JPG
do
	echo $file
	mv $file ${file%%.JPG}.jpg;
done

