#!/usr/bin/python
# -*- coding:utf-8 -*-

import os
import sys

cmd_folder = os.path.dirname(os.path.abspath(__file__))
if cmd_folder not in sys.path:
    sys.path.insert(0, cmd_folder)

from graph import Graph
from graph import RandomStrategy
from graph import VRandomStrategy
from graph import CompleteStrategy
from graph import TBFStrategy

from community import analysis

from plot import makeEvolution

if sys.argv > 1:
    g = Graph(sys.argv[1])
else:
    sys.exit("Pas d'arguments donné")

# Utilisation des stratégies du cours

sample = Graph()
output_folder = "output/" + sys.argv[1]
output_folder = output_folder.replace('/data', '')


def makeGraph(folder):
    for f in os.listdir(folder):
        if os.path.isfile(os.path.join(folder, f)) and \
                os.path.splitext(f)[1] == ".dataset":
            c = "cut --delimiter=' ' --fields=2,3 %s > %s" % \
                    (os.path.join(folder, f),\
                    (os.path.join(folder, os.path.splitext(f)[0]) + ".graph"))
            os.system(c)


def runSimulation(l):
    global output_folder
    folder = output_folder + "/" + str(l) + "/"

    if not os.path.exists(folder):
        os.makedirs(folder)

    # Création des traces d'explorations

    RandomStrategy(g, sample, l, folder + "/random.dataset")
    sample.EraseLink()
    VRandomStrategy(g, sample, l, folder + "/vrandom.dataset")
    sample.EraseLink()
    CompleteStrategy(g, sample, l, folder + "/complete.dataset")
    sample.EraseLink()
    TBFStrategy(g, sample, l, folder + "/tbf.dataset")
    sample.EraseLink()

    # Fabrication des graphes

    makeGraph(folder)

    # Analyse des communautés

    for f in os.listdir(folder):
        print f
        if os.path.isfile(os.path.join(folder, f)) and \
                os.path.splitext(f)[1] == ".graph":
            analysis(os.path.join(folder, os.path.splitext(f)[0]))

    # Préparation de l'evolution du nombre de liens découverts

    makeEvolution(folder)

    # On balance le template de plot dans chaque fichier

    os.system("cp plot.gnuplot %s" % folder)

runSimulation(100)
runSimulation(1000)
runSimulation(10000)
