set terminal postscript eps enhanced 9
set output "q22a-n.eps"
set size 0.36,0.4
set lmargin 11
set rmargin 2

set xlabel 'N'
set ylabel 'Taux de perte'

set logscale y

set xrange [ 0 : 300 ]

set arrow from 0,1e-4 to 300,1e-4 nohead ls 2
plot '../../src/out-q22a-n/results' \
  u 1:2:3 w yerrorbars t 'Taux de perte' lc rgb '#996600'

!epstopdf q22a-n.eps && rm q22a-n.eps 

# vi:ft=gnuplot:ts=2:et:

