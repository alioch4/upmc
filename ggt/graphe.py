#!/usr/bin/python
# -*- coding:utf-8 -*-

import csv
import random

# On suppose que les noeuds du graphe sont stockés de 0 à n-1
# Si on trouve le noeud 42 cela veut dire que l'on a des noeuds de 0
# à 42

class Graph():

    n = 0 # Nombre de noeuds
    m = 0 # Nombre d'arêtes
    density = 0.0
    nodes = dict()
    degree = dict()

    def __init__(self, address=""):
        if address != "":
            f = open( address, "r" )
            reader = csv.reader(f, delimiter=" ")

            for i in reader:
                self.m += 1
                self.AddNode(int(i[0]), int(i[1]))
                self.AddNode(int(i[1]), int(i[0]))
            self.density = float(2*self.m)/float(self.n*(self.n-1))

    def __str__(self):
        return str(self.nodes)

    def AddNode(self, node1, node2):
        if( node1 > self.n ):
            self.n = int(node1) + 1
        if( self.nodes.has_key( node1 ) ):
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] += 1
        else:
            self.nodes[ node1 ] = set()
            self.nodes[ node1 ].add( node2 )
            self.degree[ node1 ] = 1

    def Degree( self ):
        res = self.degree
        for i in range(0,self.n):
            if not res.has_key(i):
                res[i] = 0
        return res

    # Nombre de sommets de degré 0

    def ZeroDegree( self ):
        res = 0
        for i in range(0,self.n):
            if not self.degree.has_key(i):
                res += 1
        print res
        return res

    # Distribution des degrés du graphe

    def DistDegree( self, address="" ):
        res = dict()
        for i in self.Degree().values():
            if i in res:
                res[i] += 1
            else:
                res[i] = 1
        if(address == ""):
            print res
        else:
            f = open(address,"w")
            for i in res.keys():
                f.write("%s %s\n" % (i,res[i]))
            f.close()

    def MinDegree( self ):
        return min(self.degree.values())

    def MaxDegree( self ):
        return max(self.degree.values())

    def MeanDegree( self ):
        print self.degree.values()
        return sum(self.degree.values())/ len(self.degree.values())

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
    g.DistDegree("graphe.data")

# Generation d'un graphe à partir d'une liste de degrés

def GenerateDegree( f ):
    pass

g = Graph("graphe.txt")
g.DistDegree("apwal.txt")

GenerateErdos( n = 7235, m = 22270 )
