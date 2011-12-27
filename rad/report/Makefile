BASENAME=rapport
PDF=$(BASENAME).pdf
LATEX=xelatex

.PHONY: clean dist-clean

pdf: $(PDF)

$(PDF): $(BASENAME).tex tex/*
	$(LATEX) -no-pdf $(BASENAME).tex
	bibtex $(BASENAME).aux
	$(LATEX) $(BASENAME).tex

clean:
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).xdv \
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
