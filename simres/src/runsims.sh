#!/bin/bash

T_INTERVALLE=10
TMAX=150

BASENAME=$1
if [ -z $BASENAME ]; then BASENAME=sim; fi

[ ! -d out ] && mkdir out
echo "Running simulations"
for i in $BASENAME-*.tcl; do echo "ns $i"; ns $i > out/${i/tcl/out}; done
echo "Calculating IC"
for i in out/*.out; do echo "$i (t=$T_INTERVALLE, tmax=$TMAX)"; ./ic.pl $T_INTERVALLE $TMAX <$i > ${i}2; done
