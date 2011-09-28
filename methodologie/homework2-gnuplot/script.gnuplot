plot 'dataset.txt' using 1:($4-$3), 2:($4-$3)

set terminal postscript eps enhanced
set output 'enhanced.eps'
replot
