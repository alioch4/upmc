.PHONY: gfx clean hierarchy

GNUPLOT=gnuplot

IMAGES=q21.pdf q21a.pdf q21b.pdf q22a-n.pdf q22b-rio.pdf

ifeq ($(VERBOSE), 1)
	Q =
else
	Q=@ 
endif


gfx: $(IMAGES)

clean:
	rm -f $(IMAGES)


# Chaque .plt doit contenir la ligne suivante a la fin:
# !epstopdf foo.eps && rm foo.eps
%.pdf: %.plt
	@echo '  GNUPLOT  $@'
	$(Q)$(GNUPLOT) $<
