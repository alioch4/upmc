set xlabel 'Degree'
set ylabel 'Occurences'
set datafile separator " "
set style fill

set terminal postscript eps enhanced 9
set output "img/degree.eps"
set size 0.36, 0.5


plot 'graphe.data'

!epstopdf img/degree.eps && rm img/degree.eps

# vim:ft=gnuplot
