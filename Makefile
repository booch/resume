all: resume.txt resume.html resume.pdf
.PHONY: all

# Create text version from Markdown. (Remove double asterisks (except for a line of asterisks) and header attributes.)
%.txt: %.md
	sed -e '/^\**$$/! s/\*\*//g' -e 's/{.*}//g' $< > $@

# Create HTML version from Markdown (via Kramdown). Then tidy up the HTML.
%.html: %.md resume-template.html.erb
	kramdown $< --template resume-template.html.erb > $@
	tidy -indent -bare -quiet -utf8 -modify --tidy-mark no $@

# Create PDF from HTML (via wkhtmltopdf).
%.pdf: %.html footer.html.erb
	erb footer.html.erb > footer.html
	wkhtmltopdf --print-media-type --page-size 'Letter' --encoding 'UTF8' \
		--footer-html footer.html \
		--margin-top 30pt --margin-bottom 24pt --margin-left 60pt --margin-right 60pt \
		--title "Craig Buchek's résumé" \
		$< $@
