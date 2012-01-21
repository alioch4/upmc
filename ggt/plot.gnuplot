#!/usr/bin/gnuplot -persist

set title "flikr-test / Evolution du nombre de liens découverts"
set xlabel 'Liens testés'
set ylabel 'Liens découverts'
set datafile separator ","
set style fill

#plot "output/flikr-test.graph/evolution.plot" using 2:1 title 'random' with lines,\
#"output/flikr-test.graph/evolution.plot" using 3:1 title 'vrandom' with lines, \
#"output/flikr-test.graph/evolution.plot" using 4:1 title 'tbf' with lines,\
#"output/flikr-test.graph/evolution.plot" using 5:1 title 'complete' with lines

plot "output/flikr.graph/evolution.plot" using 1:2 title 'random' with lines,\
"output/flikr.graph/evolution.plot" using 1:3 title 'vrandom' with lines, \
"output/flikr.graph/evolution.plot" using 1:4 title 'tbf' with lines,\
"output/flikr.graph/evolution.plot" using 1:5 title 'complete' with lines

pause -1

# vim:ft=gnuplot
