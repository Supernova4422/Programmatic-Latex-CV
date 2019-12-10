#!/usr/bin/env bash

NAME="CV NAME" # This determines the output filename
declare -a audiences=("onePage" "one" "two" "three")

# Clean previous build
rm -r "output"
#Build All files
mkdir "output"
mkdir "output/plaintext"
mkdir "output/html"
mkdir "output/rtf"

# Create audiences.tex. ALL audiences must be included for latex compilation
# to complete succesfully.
cd main
touch audiences.tex
rm audiences.tex
echo "% Generated file" >> audiences.tex
for i in "${audiences[@]}"
do
	echo "\SetNewAudience{AUDIENCE${i}}" >> audiences.tex
done

for i in "${audiences[@]}"
do
	tex_filename="${i}.tex"
	txt_filename="${i}.txt"
	html_filename="${i}.html"
	rtf_filename="${i}.rtf"
	audience="AUDIENCE$i"
	# Compile plaintext and pdf files

	rm $tex_filename # Remove if it already exists
	echo "% Generated file" >>  $tex_filename
	echo "\def\CurrentAudience{$audience}\input{body.tex}" >> $tex_filename
	xelatex $tex_filename
	pandoc --columns 79 --pdf-engine xelatex -s $tex_filename -t plain -o $txt_filename
	pandoc --columns 79 --pdf-engine xelatex -s $tex_filename -o $html_filename
	pandoc --columns 79 --pdf-engine xelatex -s $tex_filename -o $rtf_filename

	# Sanatise plaintext files
	declare -a outFiles=($txt_filename $html_filename $rtf_filename)
	for j in "${outFiles[@]}"
	do
		for k in "${audiences[@]}"
		do
			sed -i .bak "s/AUDIENCE${k} //g" $j
			sed -i .bak "s/AUDIENCE${k}//g" $j
		done
		sed -i .bak 's/-, //g' $j
		sed -i .bak 's/ , //g' $j
		sed -i .bak '/^$/N;/^\n$/D' $j
		sed -i .bak 's/ width$//g' $j
		sed -i .bak -e '/^, / s///' $j
		sed -i .bak -e '/>, </ s///' $j

	done

	mv $txt_filename "../output/plaintext/$txt_filename"
	mv $html_filename "../output/html/$html_filename"
	mv $rtf_filename "../output/rtf/$rtf_filename"
	mkdir "../output/${i}/"
	mv "${i}.pdf" "../output/${i}/$NAME CV.pdf"
done

#Clean build files
rm *.log
rm *.out
rm *.aux
rm *.fls
rm *.latexmk
rm *.bak