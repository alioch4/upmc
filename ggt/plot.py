#! /usr/bin/python
# -*- coding: utf-8 -*-

import matplotlib
import os
#from pyplot import plotfile
from pylab import show
from matplotlib.backends.backend_pdf import PdfPages

pp = PdfPages('test.pdf')
data_folder = "output/"

# Idées de stratégies :
# - Evolution du coefficient de clustering
# - Evolution du nombre d'arêtes découvertes
# - Evolution du nombre de noeuds découverts
# - Combien de temps il faut pour avoir 95 % du parc découvert avec
# chaque stratégie


def maxline():
    res = dict()
    for fichier in os.listdir(data_folder):
        if os.path.isfile(data_folder + fichier):
            f = open(data_folder + fichier, 'r')
            i = 0
            for line in f:
                i += 1
            res.setdefault(i, []).append(data_folder + fichier)
    return max(res.keys())


def extract(string):
    if string == "":
        return "None"
    else:
        return string.split()[0]

def prepareEvolution():
    output_name = "evolution.dataset"
    output = open(output_name, "w")
    opened = list()

    # Création de la liste des fichiers à ouvrir

    for dataset in os.listdir(data_folder):
        input_address = data_folder + dataset
        if os.path.isfile(input_address) and dataset != output_name:
            input_file = open(input_address)
            opened.append({"name": dataset, "fichier" : input_file})

    # Création du header

    header = "discovered"
    for dataset in opened:
        header += "," + dataset["name"].replace(".dataset","")
    header += "\n"
    output.write(header)

    # Ajout du contenu

    for i in range(1, maxline()):
        line = str(i)
        for item in opened:
            line += "," + extract(item["fichier"].readline())
        line += "\n"
        output.write(line)


def Evolution():
    prepareEvolution()
    r = matplotlib.mlab.csv2rec("evolution.dataset", missing="None",\
            delimiter=',', names=None)
    print r.random
    #plotfile("evolution.dataset", cols=(1, 0), subplots=False,\
    #        missing="None", newfig=False)
    show()
Evolution()
