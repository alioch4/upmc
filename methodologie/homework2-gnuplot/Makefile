MAIN_FILE = main

gnuplot:
	gnuplot scripts/script.gnuplot

pdf:
	xelatex ${MAIN_FILE}.tex
	bibtex ${MAIN_FILE}.aux
	xelatex ${MAIN_FILE}.tex
	xelatex ${MAIN_FILE}.tex
	
clean:

	rm -f *.aux *.bbl *.blg *.bst *.dvi *.idx *.lof *.log *.toc *.out *.synctex.gz *.glo *.ind *.ilg *.pdfsync
