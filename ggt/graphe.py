#!/usr/bin/python
# -*- coding:utf-8 -*-

from __future__ import division

import csv
import random

# On suppose que les noeuds du graphe sont stockés de 0 à n-1
# Si on trouve le noeud 42 cela veut dire que l'on a des noeuds de 0
# à 42

class Graph():

    n = 0 # Nombre de noeuds
    m = 0 # Nombre d'arêtes
    density = 0
    nodes = dict()
    degree = dict()

    def __init__(self, address=""):
        if address != "":
            f = open( address, "r" )
            reader = csv.reader(f, delimiter=" ")

            for i in reader:
                self.m += 1
                self.AddNode(i[0], i[1])
                self.AddNode(i[1], i[0])
            density = (2*int(self.m))/(int(self.n)*(int(self.n)-int(1)))

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

    def ZeroDegree( self ):
        res = 0
        print self.degree.values()

    # Distribution des degrés du graphe

    def DistDegree( self, value ):
        res = dict()
        for i in self.degree:
            if( res.has_key( i ) ):
                res[i] += 1
            else:
                res[i] = 1
        print res

        if( value != null ):
            f = open(value,"w")
            f.write(res)
        return res

    def MinDegree( self ):
        return min(self.degree.values())

    def MaxDegree( self ):
        return max(self.degree.values())

    def MeanDegree( self ):
        return sum(self.degree.values())/len(self.degree.values)

    def Print(self, address=""):
        print 'Il faut imprimer le graphe en question dans un fichier de\
        sauvegarde'
        f = open(address,"w")
        for i in self.nodes.keys():
            for j in self.nodes[i]:
                print str(i)+" "+str(j)


# Generation d'un graphe aléatoire Erdös-Rényi

def GenerateErdos(n, m):
    g = Graph()
    g.n = n
    for i in range(1,m):
        a = random.randint(0, n-1)
        b = random.randint(0, n-1)
        while( a == b ):
            a = random.randint(0, n-1)
            b = random.randint(0, n-1)
        g.AddNode(a,b)
        g.AddNode(b,a)
    g.Print("graphe.data")

print random.randint(0, 42)

# Generation d'un graphe à partir d'une liste de degrés

def GenerateDegree( f ):
    pass

g = Graph("graphe.txt")
print 'Voici une representation du graphe'
print g
print 'Voici la distribution des degrés dans le graphe'
print g.degree
print 'Voici le nombre de noeuds dans le graphe'
print g.n
print 'Voici le nombre de noeuds de degrés 0'
g.ZeroDegree()

#GenerateErdos( n = 7235, m = 22270 )
