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

g = Graph("data/flikr-test")

# Utilisation des stratégies du cours

sample = Graph()
RandomStrategy(g, sample, 100000, "output/random-strategy.dataset")
sample.EraseLink()
VRandomStrategy(g, sample, 100000, "output/vrandom-strategy.dataset")
sample.EraseLink()
CompleteStrategy(g, sample, 100000, "output/complete-strategy.dataset")
sample.EraseLink()
TBFStrategy(g, sample, 100000, "output/tbf-strategy.dataset")
sample.EraseLink()
