
default:
	landslide -i -l no -t theme -r slides.md 

pdf: default
	prince presentation.html -s theme/css/pdf.css -o out.pdf
	
