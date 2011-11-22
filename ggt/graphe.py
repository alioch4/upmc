#!/usr/bin/python
# -*- coding:utf-8 -*-

import csv

class Graph():

    n = 0 # Nombre de noeuds
    m = 0 # Nombre d'arêtes
    nodes = dict()

    def AddNode(self, node1, node2):
        if( self.nodes.has_key( node1 ) ):
            self.nodes[ node1 ].add( node2 )
            self.nodes[ node1 ]["degree"] += 1
        else:
            self.nodes[ node1 ] = dict()
            self.nodes[ node1 ]["degree"] = 1


    def CreateGraph(self, *args, **options):
        f = open( args[1], "r" )
        reader = csv.reader(f, delimiter=" ")

        for i in reader:
            self.AddNode(self, i[0], i[1])
            self.AddNode(self, i[1], i[0])

    def DegreeGraph(self):
        res = dict()
        for i in self.nodes:
            self.nodes


    # Nombre de noeuds dans le graphe

    def CardGraph( self ):
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
        for i in self.nodes:
            if( res.has_key( i["degree"] ) ):
                res[i["degree"]] +=
            else:
                res[ i["degree"] ] = 1
        return res


g = Graph()
g.CreateGraph("graphe.txt")
