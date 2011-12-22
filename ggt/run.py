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
RandomStrategy(g, sample, 42)
sample.clear()
VRandomStrategy(g, sample, 42)
sample.clear()
CompleteStrategy(g, sample, 42)
sample.clear()
TBFStrategy(g, sample, 42)
sample.clear()
