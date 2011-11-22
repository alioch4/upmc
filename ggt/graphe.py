#!/usr/bin/python
# -*- coding:utf-8 -*-

import csv

class Graph():

    n = 0 # Nombre de noeuds
    m = 0 # Nombre d'arêtes
    nodes = dict()
    degree = dict()

    def __init__(self, value):
        f = open( value, "r" )
        reader = csv.reader(f, delimiter=" ")

        for i in reader:
            self.AddNode(i[0], i[1])
            self.AddNode(i[1], i[0])

    def __str__(self):
        return str(self.nodes)

    def AddNode(self, node1, node2):
        if( self.nodes.has_key( node1 ) ):
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] += 1
        else:
            self.nodes[ node1 ] = set()
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] = 1

    def DegreeGraph(self):
        res = dict()
        for i in self.nodes:
            self.nodes


    # Nombre de noeuds dans le graphe

    def CardGraph():
        return self.n

    # Nombre de sommets de degré 0

    def ZeroDegreeGraph( self ):
        res = 0
        for i in self.nodes:
            if i["degree"] == 0 :
                res += 1
        return res

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
print g
print g.degree
