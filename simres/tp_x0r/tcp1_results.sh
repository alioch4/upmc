#!/bin/sh

for i in tcp1-10k-1ns tcp1-50M-1ns tcp1-50M-200ms; do
	grep '^+' $i.tr | awk '{ print $2, $11 }' > $i-send.dat
	grep '^-' $i.tr | awk '{ print $2, $11 }' > $i-recv.dat
done
