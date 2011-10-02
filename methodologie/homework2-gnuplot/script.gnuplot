set ylabel "Temps de conversation moyen"
set xlabel "Identifiant chercheurs"

plot 'dataset.txt' using 1:($4-$3) with lines
plot 'dataset.txt' using 2:($4-$3) with lines


set terminal postscript eps enhanced
set output 'enhanced.eps'
replot
