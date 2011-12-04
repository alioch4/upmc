#!/usr/bin/python
# -*- coding:utf-8 -*-

import os, sys

cmd_folder = os.path.dirname(os.path.abspath(__file__))
if cmd_folder not in sys.path:
    sys.path.insert(0, cmd_folder)

from graph import *



g = GenerateDegreeRandom("data/graphe.data")

