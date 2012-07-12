# Délais en fonction de b et de la stratégie d'ordonnancement choisie

set terminal postscript eps enhanced 9
set output "q21a.eps"
set size 0.36,0.4
set lmargin 10
set rmargin 2

set xlabel 'b'
set ylabel 'Delai'

set key top left

plot '../../src/out-q21a-none/result' \
    u 1:2:3 w yerrorbars lc rgb '#ff0000' t '(aucun)', \
  '../../src/out-q21a-rr/result' \
    u 1:2:3 w yerrorbars lc rgb '#009900' t 'RR', \
  '../../src/out-q21a-wrr/result' \
    u 1:2:3 w yerrorbars lc rgb '#0044cc' t 'WRR', \
  '../../src/out-q21a-pri/result' \
    u 1:2:3 w yerrorbars lc rgb '#cc0099' t 'PRI'

!epstopdf q21a.eps && rm q21a.eps

# vi:ft=gnuplot:ts=2:et:
