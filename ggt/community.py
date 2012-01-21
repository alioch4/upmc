#!/usr/bin/python
# -*- coding: utf-8 -*-

# Il faut utiliser viser le jeu de données qui est dans le sous repertoire data
# directement sans mettre son chemin exact. il faut juste donner le nom du jeu
# de données.

import sys
import os
import csv


def distribution(address):
    f = open(address, "r")
    reader = csv.reader(f, delimiter=" ")

    res = dict()
    pool = dict()

    for i in reader:
        if int(i[1]) in pool:
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


def conversion(data):
    os.system("community/convert -i data/" + data + ".graph" + " -o data/" + data + ".bin")

def community(data):
    os.system("community/community data/" + data + ".bin -l -1 -q 0.0001 >\
    data/" + data + ".tree")
    os.system("community/community data/" + data + ".bin -l -1 -q 0.0001 >\
    data/" + data + ".tree")


def hierarchy(data):
    os.system("community/hierarchy -l 3 data/" + data + ".tree > data/" + data\
            + ".data")
    os.system("community/hierarchy -l 2 data/" + data + ".tree > data/" + data\
            + ".data")

if len(sys.argv) > 1:
    conversion(sys.argv[1])
    community(sys.argv[1])
    hierarchy(sys.argv[1])

    print "Distribution de " + sys.argv[1]
    res = distribution("data/" + sys.argv[1] + ".data")
    output = open("data/dist-" + sys.argv[1] + ".plot", "w")
    for i in res:
        output.write("%s %s\n" % (i, res[i]))
    output.close()

