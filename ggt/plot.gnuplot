#!/usr/bin/gnuplot -persist

set title "flikr-test.evolution du nombre de liens découverts"
set xlabel 'Liens testés'
set ylabel 'Liens découverts'
set datafile separator ","
set style fill

plot "output/flikr-test.graph/evolution.plot" using 1:2 title 'random' with lines,\
"output/flikr-test.graph/evolution.plot" using 1:3 title 'vrandom' with lines, \
"output/flikr-test.graph/evolution.plot" using 1:4 title 'tbf' with lines,\
"output/flikr-test.graph/evolution.plot" using 1:5 title 'complete' with lines

#plot "flikr.evolution.plot" using 1:2 title 'random' with lines,\
#"flikr.evolution.plot" using 1:3 title 'vrandom' with lines, \
#"flikr.evolution.plot" using 1:4 title 'tbf' with lines,\
#"flikr.evolution.plot" using 1:5 title 'complete' with lines

pause -1

# vim:ft=gnuplot
