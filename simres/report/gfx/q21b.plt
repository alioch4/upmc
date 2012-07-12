# "Avant" => poids 50 pour la voix, 310 pour data + video
# "Après" => poids 400 pour la voix, 60 pour le reste

set terminal postscript eps enhanced 9
set output "q21b.eps"
set size 0.36,0.4
set lmargin 10
set rmargin 2

set xlabel 'b'
set ylabel 'Delai'

set key top left

plot '../../src/out-q21a-wrr/result' \
    u 1:8:9 w yerrorbars lc rgb '#ee7700' t 'Voix (avant)', \
  '../../src/out-q21a-wrr/result' \
    u 1:2:3 w yerrorbars lc rgb '#ffcc88' t 'Global (avant)', \
  '../../src/out-q21b-wrr2/result' \
    u 1:8:9 w yerrorbars lc rgb '#0044cc' t 'Voix (apres)', \
  '../../src/out-q21b-wrr2/result' \
    u 1:2:3 w yerrorbars lc rgb '#88ccff' t 'Global (apres)'

!epstopdf q21b.eps && rm q21b.eps

# vi:ft=gnuplot:ts=2:et:
