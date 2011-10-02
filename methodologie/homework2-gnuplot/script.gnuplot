set xlabel 'Normalized mean chat time'
set ylabel 'Normalized number of chat'
set datafile separator ';'
set style fill

set terminal postscript eps enhanced 9
set output "part1.eps"
set size 0.36,0.5


plot 'data2.txt' using ($2-0.3):3:(0.3) w boxes \
    fs solid lc rgb '#2244cc' \
    title 'Mean time per contact', \
  'data2.txt' using ($2+0.1):4:(0.3) w boxes \
    fs solid lc rgb '#cc8822' \
    title "total time", \
  'data2.txt' using ($2+0.1):5:(0.3) w boxes \
    fs solid lc rgb '#cafefe' \
    title "Number of contacts" \

!epstopdf part1.eps && rm part1.eps

# vim:ft=gnuplot:
