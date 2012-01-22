#! /usr/bin/python
# -*- coding: utf-8 -*-

import os

# Idées de stratégies :
# - Evolution du coefficient de clustering
# - Evolution du nombre d'arêtes découvertes
# - Evolution du nombre de noeuds découverts
# - Combien de temps il faut pour avoir 95 % du parc découvert avec
# chaque stratégie


def maxline(data_folder):
    res = dict()
    for fichier in os.listdir(data_folder):
        if os.path.isfile(os.path.join(data_folder, fichier)):
            f = open(os.path.join(data_folder, fichier), 'r')
            i = 0
            for line in f:
                i += 1
            res.setdefault(i, []).append(\
                os.path.join(data_folder, fichier))
    return max(res.keys())


def extract(string):
    if string == "":
        return "None"
    else:
        return string.split()[0]


def makeEvolution(data_folder):
    output_name = "evolution.plot"
    output = open(data_folder + output_name, "w")
    opened = list()

    # Création de la liste des fichiers à ouvrir

    for dataset in os.listdir(data_folder):
        input_address = os.path.join(data_folder, dataset)
        if os.path.isfile(input_address) and \
                os.path.splitext(dataset)[1] == ".dataset":
            input_file = open(input_address)
            opened.append({"name": dataset, "fichier": input_file})

    # Création du header
    header = "#discovered"
    for dataset in opened:
        header += "," + dataset["name"].replace(".dataset", "")
    header += "\n"
    output.write(header)

    # Ajout du contenu

    for i in range(1, maxline(data_folder)):
        line = str(i)
        for item in opened:
            line += "," + extract(item["fichier"].readline())
        line += "\n"
        output.write(line)
