#! /usr/bin/python
# -*- coding: utf-8 -*-

import os
import matplotlib.pyplot as plt
from matplotlib.backends.backend_pdf import PdfPages

pp = PdfPages('test.pdf')

"""
Example of file io, reading and writing array files. Does csv format.
"""

data_folder = "output/"

for dataset in os.listdir(data_folder):
    f = open(data_folder + dataset, "r")
    plt.plotfile(f, (0,1,2), delimiter=" ", subplots=False)
    pp.savefig()
    pp.close()
