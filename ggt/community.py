#!/usr/bin/python
# -*- coding: utf-8 -*-

# Il faut utiliser viser le jeu de données qui est dans le sous repertoire data
# directement sans mettre son chemin exact. il faut juste donner le nom du jeu
# de données.

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


def conversion(graph, output):
    os.system("community/convert -i " + graph + " -o " + output)


def community(binaire, tree, log):
    os.system("community/community " + binaire + " -l -1 -q 0.0001 > " + tree\
            + " &>> " + log)


def hierarchy(tree, hierarchy, log):
    os.system("community/hierarchy -l 3 " + tree + " > " + hierarchy + " &>> "\
            + log)
    os.system("community/hierarchy -l 2 " + tree + " > " + hierarchy + " &>> "\
            + log)


def analysis(target):
    conversion(target + ".graph", target + ".bin")
    community(target + ".bin", target + ".tree", target + ".log")
    hierarchy(target + ".tree", target + ".data", target + ".log")

    print "Distribution de " + target
    res = distribution(target + ".data")
    output = open(target + ".plot", "w")
    for i in res:
        output.write("%s %s\n" % (i, res[i]))
    output.close()
