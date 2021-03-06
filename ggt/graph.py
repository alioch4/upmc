#!/usr/bin/python
# -*- coding:utf-8 -*-

import csv
import random

from collections import defaultdict
from Queue import Queue
from itertools import product

# On suppose que les noeuds du graphe sont stockés de 0 à n-1
# Si on trouve le noeud 42 cela veut dire que l'on a des noeuds de 0
# à 42


class Graph():

    def __init__(self, address=""):

        self.n = 0  # Nombre de noeuds
        self.m = 0  # Nombre d'arêtes
        self.density = 0.0
        self.nodes = dict()
        self.degree = dict()
        if address != "":
            f = open(address, "r")
            reader = csv.reader(f, delimiter=" ")

            for i in reader:
                self.m += 1
                self.AddNode(int(i[0]), int(i[1]))
                self.AddNode(int(i[1]), int(i[0]))
            self.density = float(2 * self.m) / float(self.n * (self.n - 1))

    def __str__(self):
        return str(self.nodes)

    def AddNode(self, node1, node2):
        if(node1 > self.n):
            self.n = int(node1) + 1
        if node1 in self.nodes:
            self.nodes[node1].add(node2)
            self.degree[node1] += 1
        else:
            self.nodes[node1] = set()
            self.nodes[node1].add(node2)
            self.degree[node1] = 1

    def Degree(self):
        res = self.degree
        for i in range(0, self.n):
            if not i in res:
                res[i] = 0
        return res

    def EraseLink(self):
        for i in self.nodes:
            self.nodes[i].clear()

    # Nombre de sommets de degré 0

    def ZeroDegree(self):
        res = 0
        for i in range(0, self.n):
            if not i in self.degree:
                res += 1
        print res
        return res

    # Distribution des degrés du graphe

    def DistDegree(self, address=""):
        res = defaultdict(int)
        for i in self.Degree().values():
            res[i] += 1
        if(address == ""):
            print res
        else:
            f = open(address, "w")
            for i in res.keys():
                f.write("%s %s\n" % (i, res[i]))
            f.close()

    def MinDegree(self):
        return min(self.degree.values())

    def MaxDegree(self):
        return max(self.degree.values())

    def MeanDegree(self):
        print self.degree.values()
        return sum(self.degree.values()) / len(self.degree.values())

    def TestLien(self, node1, node2):
        if(node1 in self.nodes and node2 in self.nodes):
            res = set([node2]).issubset(self.nodes[node1])
            return res

    def Parcours(self, source, destination):

        q = Queue()
        parent = {}
        q.put(source)
        parent[source] = 'Root'

        while not q.empty():
            # get the current node and add its neighbours to queue
            current = q.get()
            for i in self.nodes[current]:
                # mark parent and only continue if not already visited
                if i not in parent:
                    parent[i] = current
                    q.put(i)
            # Check if destination
            if current == destination:
                break

    def ExistingLink(self):
        visited = set()
        for i in self.nodes:
            for j in self.nodes[i]:
                if i < j:
                    visited.add((i, j))
                else:
                    visited.add((j, i))
        return visited

# Plus grosse composante connexe
# TODO : Reutilisation du code de Parcours

    def BiggerConnexComp(self, address):
        to_explore = set()
        component = dict()
        index = 0
        q = []
        for item in self.nodes.keys():
            to_explore.add(item)

        # Construction des différentes composantes connexes

        while to_explore or q:
            while q:
                current = q.pop(0)
                todo = self.nodes[current]
                todo.add(current)
                for i in todo:
                    if i in to_explore:
                        to_explore.remove(i)
                        q.extend(self.nodes[i])
                        component[index].add(i)
            if to_explore:
                index += 1
                component[index] = set()
                q.append(random.sample(to_explore, 1)[0])

        # On selectionne la composante en question

        for i in component:
            if(len(component[i]) > len(component[index])):
                index = i

        # On selectionne les noeuds de cette partie du graphe et on va l'écrire
        # dans un fichier

        f = open(address, "w")
        for vertex in component[index]:
            for l in self.nodes[vertex]:
                f.write(str(vertex) + " " + str(l) + "\n")
        return component[index]

# Molloy & Reed


def GenerateDegreeRandom(address):
    f = open(address, "r")
    reader = csv.reader(f, delimiter=" ")

    g = Graph()
    pool = dict()
    link = 0  # Indice d'arêtes
    vertex = 0  # Indice de noeud
    for ligne in reader:
        for i in range(0, int(ligne[1])):
            for j in range(0, int(ligne[0])):
                pool[link] = vertex
                link += 1
            vertex += 1

    # On autorise les liens ou source et destination peuvent être
    # egaux
    # Attention si on selectionne plusieurs fois le meme couple de noeud
    # On peut avoir des resultats legerements différents

    while(pool):
        a = 0
        b = 0
        while(a == b):
            a = random.choice(pool.keys())
            b = random.choice(pool.keys())
        g.AddNode(pool[a], pool[b])
        g.AddNode(pool[b], pool[a])

        for i in [a, b]:
            if i in pool:
                del(pool[i])
    return g

# Generation d'un graphe aléatoire Erdös-Rényi


def GenerateErdos(n, m):
    g = Graph()
    g.n = n
    for i in range(1, m):
        a = random.randint(0, n - 1)
        b = random.randint(0, n - 1)
        while(a == b):
            a = random.randint(0, n - 1)
            b = random.randint(0, n - 1)
        g.AddNode(a, b)
        g.AddNode(b, a)
    g.DistDegree("graphe.data")


# Utilitaires pour l'exploration de graphe

# Routine d'exploration d'un lien. On utilise cette routine
# dans toutes les stratégies.

def linkExploration(original, sample, node1, node2, i, visited, output):
    # On remet les noeuds en ordre
    if(node1 > node2):
        node2, node1 = node1, node2
    # On teste si on a deja visité ce lien ou non
    test_visited = (node1, node2) in visited
    # On test si un lien entre les node1 et node2 existe et si c'est le
    # cas, l'ajoute à l'échantillon.
    # On renvoit une chaine de caractère à imprimer si la detection
    # a fonctionné et une chaine vide si ce n'est pas le cas.
    if original.TestLien(node1, node2):
        sample.AddNode(node1, node2)
        sample.AddNode(node2, node1)
        res = "%s %s %s\n" % (i, node1, node2)
    else:
        res = ""
    if res and not test_visited:
        output.write(res)
        return (node1, node2)
    else:
        return ()


def analyse(n, m, t):
    res = dict()
    density = float(2 * m) / float(n * (n - 1))
    res['best'] = 0.5 * t * t
    res['worse'] = 0
    if(t > m):
        res['best'] += m * (t - m)
    if(t > n * (n - 1) / 2 - m):
        res['worse'] = \
                (t - (n * (n - 1) / 2 - m)) * (t - (n * (n - 1) / 2 - m))
    res['random'] = 0.5 * t * t * density
    return res

# Stratégies d'exploration


def RandomStrategy(original, sample, k, output):
    print "Random Strategy running..."
    visited = set()
    borne = original.m
    f = open(output, "w")
    for i in range(1, k):
        if len(visited) >= borne:
            return sample
        else:
            u = random.randint(0, original.n)
            v = random.randint(0, original.n)
            res = linkExploration(original, sample, u, v, i, visited, f)
            if res:
                visited.add(res)
    f.close()
    print "Random strategy finished !"
    return sample


def VRandomStrategy(original, sample, k, output):
    print "Vrandom strategy running..."
    f = open(output, "w")
    visited = set()
    i = int()
    for _ in range(1, k):
        if len(visited) >= original.m:
            return sample
        else:
            i += 1
            u = random.randint(0, original.n)
            v = random.randint(0, original.n)
            res = linkExploration(original, sample, u, v, i, visited, f)
        if res:
            visited.add(res)
            for w in sample.nodes[u]:
                couple = linkExploration(original, sample, w, v, i, visited, f)
                if couple:
                    visited.add(couple)
                i += 1
            for w in sample.nodes[v]:
                couple = linkExploration(original, sample, u, w, i, visited, f)
                if couple:
                    visited.add(couple)
                i += 1
    f.close()
    print "Vrandom strategy finished !"
    return sample


def CompleteStrategy(original, sample, k, output):
    print "Complete strategy running..."
    sample = RandomStrategy(original, sample, k, output)
    visited = sample.ExistingLink()
    f = open(output, "a")
    # to_explore : Dictionnaire ayant pour clé un degré et
    # pour valeur une liste de noeuds qui ont ce degré
    to_explore = dict()
    for item in sample.nodes:
        to_explore.setdefault(sample.degree[item], []).append(item)
    # On se place après la phase aléatoire.
    i = k
    while to_explore:
        key_max = max(to_explore.keys())
        if to_explore[key_max] == []:
            del(to_explore[key_max])
        else:
            u = to_explore[key_max].pop()
            for v in original.nodes:
                i += 1
                res = linkExploration(original, sample, u, v, i, visited, f)
                if res:
                    visited.add(res)
                    if sample.degree[v] == 1:
                        to_explore.setdefault(1, []).append(v)
    f.close()
    print "Complete strategy finished !"
    return sample


def TBFStrategy(original, sample, k, output):
    print "TBF strategy running..."
    sample = RandomStrategy(original, sample, k, output)
    visited = sample.ExistingLink()
    f = open(output, "a")
    somme = dict()

    for u, v in product(sample.nodes, sample.nodes):
        if u > v:
            u, v = v, u
            value = sample.degree[u] + sample.degree[v]
            somme.setdefault(value, set()).add((u, v))

    # Exploitation de la liste composée des sommes des degrés d(u) + d(v)
    i = k
    while somme:
        key_max = max(somme.keys())
        if not somme[key_max]:
            del(somme[key_max])
        else:
            u, v = somme[key_max].pop()
            i += 1
            res = linkExploration(original, sample, u, v, i, visited, f)
            if res:
                visited.add(res)
    f.close()
    print "TBF strategy finished !"
    return sample

# Attention dans cette methode on ne tient pour le moment pas compte des
# eventuels rafraichissement des degres des noeuds. Il pourrait être utile
# d'appliquer de nouveau l'algorithme de TBF
