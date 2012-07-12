BASENAME=rapport
PDF=$(BASENAME).pdf
LATEX=pdflatex

.PHONY: clean dist-clean gfx

pdf: $(PDF)

$(PDF): gfx $(BASENAME).tex tex/*
	$(LATEX) -no-pdf $(BASENAME).tex
	$(LATEX) -no-pdf $(BASENAME).tex
	$(LATEX) $(BASENAME).tex

gfx:
	make -C gfx/

clean:
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).bbl \
		$(BASENAME).xdv \
		$(BASENAME).blg \
		$(BASENAME).latexmain \
		$(PDF) \
		tex/*.aux \
		tex/*.out \
		tex/*.log 2>/dev/null || /bin/true
	make -C gfx/

dist-clean: 
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		$(BASENAME).xdv \
		tex/*.aux \
		tex/*.out \
		tex/*.log 2>/dev/null || /bin/true
