set xlabel 'Scientist id'
set ylabel 'Normalized score'
set datafile separator ';'
set style fill

set terminal postscript eps enhanced 9
set output "img/part2.eps"
set size 0.36,0.5


plot 'scripts/seti-output.txt' using ($1)#:(0.2) #\
    #fs solid lc rgb '#2244cc' \
    #title 'Mean time per contact' \

!epstopdf img/part2.eps && rm img/part2.eps

# vim:ft=gnuplot:
