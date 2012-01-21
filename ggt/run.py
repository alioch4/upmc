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

if sys.argv > 1:
    g = Graph(sys.argv[1])
else:
    sys.exit("Pas d'arguments donné")

# Utilisation des stratégies du cours

sample = Graph()
output_folder = "output/" + sys.argv[1]
output_folder = output_folder.replace('/data','')

if not os.path.exists(output_folder):
    os.makedirs(output_folder)
RandomStrategy(g, sample, 100000, output_folder + "/random.dataset")
sample.EraseLink()
VRandomStrategy(g, sample, 100000, output_folder + "/vrandom.dataset")
sample.EraseLink()
CompleteStrategy(g, sample, 100000, output_folder + "/complete.dataset")
sample.EraseLink()
TBFStrategy(g, sample, 100000, output_folder + "/tbf.dataset")
sample.EraseLink()
