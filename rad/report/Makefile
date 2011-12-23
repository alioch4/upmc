BASENAME=rapport
PDF=$(BASENAME).pdf
LATEX=xelatex

.PHONY: clean dist-clean

pdf: $(PDF)

$(PDF): $(BASENAME).tex tex/*
	$(LATEX) $(BASENAME).tex
	$(LATEX) $(BASENAME).tex
	rm -f $(BASENAME).toc \
		$(BASENAME).aux \
		$(BASENAME).log \
		$(BASENAME).out \
		tex/*.aux \
		tex/*.out \
		tex/*.log

