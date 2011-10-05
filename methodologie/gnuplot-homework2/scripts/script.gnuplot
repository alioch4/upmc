set xlabel 'Scientist id'
set ylabel 'Normalized score'
set datafile separator ';'
set style fill

set terminal postscript eps enhanced 9
set output "img/part1.eps"
set size 0.36,0.5


plot 'scripts/data2.txt' \
    using ($2-0.3):3:(0.2) w boxes \
    fs solid lc rgb '#2244cc' \
    title 'Mean time per contact', \
  'scripts/data2.txt' \
    using ($2-0.1):4:(0.2) w boxes \
    fs solid lc rgb '#cc8822' \
    title "total time", \
  'scripts/data2.txt' \
    using ($2+0.1):5:(0.2) w boxes \
    fs solid lc rgb '#cafefe' \
    title "Number of contacts" \

!epstopdf img/part1.eps && rm img/part1.eps

# vim:ft=gnuplot:
