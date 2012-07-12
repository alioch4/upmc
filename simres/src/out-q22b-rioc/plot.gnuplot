#!/usr/bin/gnuplot -persist

set title "Taux de perte en fonction de valeur min du RIOC"
set logscale y

plot "result" u 1:2:3 title  'global' with yerrorbars#, \
# "result" u 1:4:5 title  'video' with yerrorbars, \
# "result" u 1:6:7 title  'data' with yerrorbars, \
# "result" u 1:8:9 title  'voice' with yerrorbars

pause -1

# vim:ft=gnuplot
