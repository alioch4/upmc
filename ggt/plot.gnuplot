set title "Evolution du nombre de liens découverts"
set xlabel 'Liens testés'
set ylabel 'Liens découverts'
set datafile separator ","
set style fill

plot "evolution.dataset" using 1:2 title 'random' with lines,\
"evolution.dataset" using 1:3 title 'vrandom' with lines, \
"evolution.dataset" using 1:4 title 'tbf' with lines,\
"evolution.dataset" using 1:5 title 'complete' with lines

pause -1

# vim:ft=gnuplot
