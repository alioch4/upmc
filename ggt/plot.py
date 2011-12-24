#! /usr/bin/python
# -*- coding: utf-8 -*-

import os
#import matplotlib.pyplot as plt
from pylab import show
from pylab import plotfile
from matplotlib.backends.backend_pdf import PdfPages

pp = PdfPages('test.pdf')


data_folder = "output/"

# Idées de stratégies :
# - Evolution du coefficient de clustering
# - Evolution du nombre d'arêtes découvertes
# - Evolution du nombre de noeuds découverts
# - Combien de temps il faut pour avoir 95 % du parc découvert avec
# chaque stratégie



def prepareEvolution():
    try:
        os.mkdir(data_folder + "evolution/")
    except:
        pass
    for dataset in os.listdir(data_folder):
        input_address = data_folder + dataset
        if os.path.isfile(input_address):
            # Ajout du numéro de ligne à chaque ligne
            output_address = data_folder + "evolution/" + dataset
            f = open(input_address, "r")
            output = open(output_address, "w")
            output.write(dataset + " tested node1 node2\n")
            i = 1
            for line in f:
                output.write(str(i) + " " + line)
                i += 1

def Evolution():
    prepareEvolution()
    first_plot = data_folder + "evolution/random-strategy.dataset"
    plotfile(first_plot, cols=(1, 0), delimiter=" ", subplots=False)
    os.chdir(data_folder + "evolution/")
    for dataset in os.listdir("."):
        print dataset
        plotfile(dataset, cols=(1, 0), subplots=False, newfig=False, delimiter=" ")
    show()
Evolution()
