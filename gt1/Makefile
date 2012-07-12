BASENAME=rapport
PDF=$(BASENAME).pdf
LATEX=xelatex

.PHONY: clean dist-clean

pdf: $(PDF)

$(PDF): $(BASENAME).tex $(BASENAME).bib tex/*
	$(LATEX) -no-pdf $(BASENAME).tex
	bibtex $(BASENAME)
	$(LATEX) -no-pdf $(BASENAME).tex
	$(LATEX) $(BASENAME).tex

clean:
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).bbl \
		$(BASENAME).xdv \
		$(BASENAME).blg \
		$(PDF) \
		tex/*.aux \
		tex/*.out \
		tex/*.log 2>/dev/null || /bin/true
