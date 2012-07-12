BASENAME=rapport
PDF=$(BASENAME).pdf
LATEX=xelatex

.PHONY: clean dist-clean

pdf: $(PDF)

$(PDF): $(BASENAME).tex tex/*
	$(LATEX) -no-pdf $(BASENAME).tex
	$(LATEX) -no-pdf $(BASENAME).tex
	$(LATEX) $(BASENAME).tex

clean:
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).xdv \
		$(BASENAME).blg \
		$(BASENAME).latexmain \
		$(PDF) \
		tex/*.aux \
		tex/*.out \
		tex/*.log 2>/dev/null || /bin/true

dist-clean: 
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).xdv \
		tex/*.aux \
		tex/*.out \
		tex/*.log 2>/dev/null || /bin/true
