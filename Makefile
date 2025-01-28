all: resume.txt resume.html resume.pdf
.PHONY: all
.PHONY: setup

# Create text version from Markdown. (Remove double asterisks (except for a line of asterisks) and header attributes.)
%.txt: %.md
	sed -e '/^\**$$/! s/\*\*//g' -e 's/{.*}//g' $< > $@

# Create HTML version from Markdown. Then tidy up the HTML.
%.html: %.md resume-template.html.erb
	kramdown $< --template resume-template.html.erb > $@
	tidy -indent -bare -quiet -utf8 -modify --tidy-mark no $@

# Create PDF from HTML.
%.pdf: %.html footer.html.erb
	# erb footer.html.erb > footer.html
	weasyprint --encoding='utf8' $< $@

setup:
	./SETUP.sh
