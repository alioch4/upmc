#!/usr/bin/gnuplot -persist

set title "flikr-test / Evolution du nombre de liens découverts"
set xlabel 'Liens testés'
set ylabel 'Liens découverts'
set datafile separator ","
set style fill

plot "evolution.plot" using 2:1 title 'random' with lines,\
"evolution.plot" using 3:1 title 'vrandom' with lines, \
"evolution.plot" using 4:1 title 'tbf' with lines,\
"evolution.plot" using 5:1 title 'complete' with lines

pause -1

# vim:ft=gnuplot
