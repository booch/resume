#!/bin/bash

# Create text version from Markdown. (Remove double asterisks (except for a line of asterisks) and header attributes.)
sed -e '/^\**$/! s/\*\*//g' -e 's/{.*}//g' resume.md > resume.txt


# Create HTML version from Markdown.
pandoc resume.md --output resume.html --section-divs --to html5 --standalone --template resume-template.html

# Tidy up the HTML. (And tell tidy that the HTML5 <section> element is valid.)
tidy -indent -bare -quiet -utf8 -modify --tidy-mark no --new-blocklevel-tags section resume.html 2>/dev/null


# Create ODF text from Markdown.
pandoc resume.md --output resume.odt


# Create PDF from HTML (via pdflatex).
pandoc resume.html --output resume.pdf --template resume-template.latex -V title='Craig Buchek'
