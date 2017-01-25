#!/bin/bash

export PATH=$PATH:/usr/texbin

# Create text version from Markdown. (Remove double asterisks (except for a line of asterisks) and header attributes.)
sed -e '/^\**$/! s/\*\*//g' -e 's/{.*}//g' resume.md > resume.txt


# Create HTML version from Markdown (via Kramdown).
kramdown resume.md --template resume-template.html.erb > resume.html

# Tidy up the HTML. (And tell tidy that the HTML5 <section> element is valid.)
tidy -indent -bare -quiet -utf8 -modify --tidy-mark no --new-blocklevel-tags section resume.html 2>/dev/null


# Create PDF from HTML (via wkhtmltopdf).
erb footer.html.erb > footer.html
wkhtmltopdf --print-media-type --page-size "Letter" --encoding "UTF8" \
    --footer-html footer.html \
    --margin-top 20pt --margin-bottom 20pt --margin-left 60pt --margin-right 60pt \
    --title "Résumé - Craig Buchek" \
    resume.html resume.pdf
