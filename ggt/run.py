#!/usr/bin/python
# -*- coding:utf-8 -*-

import os, sys
cmd_folder = os.path.dirname(os.path.abspath(__file__))
if cmd_folder not in sys.path:
    sys.path.insert(0, cmd_folder)
print sys.path

from graphe import *

n_test = 0

original = Graph("data/flikr-test")
sample   = Graph("data/flikr-test")
EraseLink(sample)

test_lien( original, sample, 0, 7)

