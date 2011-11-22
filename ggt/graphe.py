#!/usr/bin/python
# -*- coding:utf-8 -*-

from __future__ import division
import csv


# On suppose que les noeuds du graphe sont stockés de 0 à n-1
# Si on trouve le noeud 42 cela veut dire que l'on a des noeuds de 0
# à 42

class Graph():

    n = 0 # Nombre de noeuds
    m = 0 # Nombre d'arêtes
    density = 0
    nodes = dict()
    degree = dict()

    def __init__(self, value):
        f = open( value, "r" )
        reader = csv.reader(f, delimiter=" ")

        for i in reader:
            self.AddNode(i[0], i[1])
            self.AddNode(i[1], i[0])
        density = (2*int(self.m))/(int(self.n)*(int(self.n)-int(1)))
        print density

    def __str__(self):
        return str(self.nodes)

    def AddNode(self, node1, node2):
        if( node1 > self.n ):
            self.n = node1
        if( self.nodes.has_key( node1 ) ):
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] += 1
        else:
            self.nodes[ node1 ] = set()
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] = 1

    # Nombre de sommets de degré 0

    def ZeroDegreeGraph( self ):
        res = 0
        print self.degree

    # Distribution des degrés du graphe

    def DistDegreeGraph( self ):
        res = dict()
        for i in self.degree:
            if( res.has_key( i["degree"] ) ):
                res[i["degree"]] += 1
            else:
                res[ i["degree"] ] = 1
        return res


g = Graph("graphe.txt")
print 'Voici une representation du graphe'
print g
print 'Voici la distribution des degrés dans le graphe'
print g.degree
print 'Voici le nombre de noeuds dans le graphe'
print g.n
print 'Voici le nombre de noeuds de degrés 0'
g.ZeroDegreeGraph()
print 'Voici la distribution des degrés du graphe :'
g.DistDegreeGraph()
