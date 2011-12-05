set xlabel 'Degree'
set ylabel 'Number'
set datafile separator " "
set style fill

set terminal postscript eps enhanced 9
set output "img/dist-flikr.eps"
set size 0.36, 0.5

plot 'data/dist-flikr.tree'

!epstopdf img/dist-flikr.eps && rm img/dist-flikr.eps

plot

# vim:ft=gnuplot
