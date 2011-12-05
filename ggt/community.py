#!/usr/bin/python
# -*- coding: utf-8 -*-

import os
import csv

def distribution( address ):
    f = open( address, "r")
    reader = csv.reader(f, delimiter=" ")

    res = dict()
    pool = dict()

    for i in reader:
        if( pool.has_key( int(i[1]) )):
            pool[int(i[1])] += 1
        else:
            pool[int(i[1])] = 1

    for i in pool.values():
        if i in res:
            res[i] += 1
        else:
            res[i] = 1

    print res
    return res


def conversion():
    os.system("community/convert -i data/flikr-test -o data/flikr-test.bin")
    os.system("community/convert -i data/flikr -o data/flikr.bin")

def community():
    os.system("community/community data/flikr-test.bin -l -1 -q 0.0001 >\
    data/flikr-test.tree")
    os.system("community/community data/flikr.bin -l -1 -q 0.0001 >\
    data/flikr.tree")

def hierarchy():
    os.system("community/hierarchy -l 3 data/flikr-test.tree >\
            data/flikr-test.data")
    os.system("community/hierarchy -l 2 data/flikr.tree > data/flikr.data")

conversion()
community()
hierarchy()

print "Distribution de flikr-test"
res = distribution("data/flikr-test.data")
output = open('data/dist-flikr-test.plot',"w")
for i in res:
    output.write("%s %s\n" % (i,res[i]))
output.close()

pass

print "Distribution de flikr"
res = distribution("data/flikr.data")
output = open('data/dist-flikr.plot',"w")
for i in res:
    output.write("%s %s\n" % (i,res[i]))
output.close()
