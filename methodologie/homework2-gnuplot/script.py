#!/usr/bin/python
# -*- coding: utf8 -*-

from __future__ import division
import csv
from collections import defaultdict


f = csv.reader(open('dataset.txt','r'),delimiter='\t')
values = ['node1','node2','begin','end']
data = list()
res = dict()
for row in f:
    row = dict(zip(values,map(int,row)))
    row['time'] = row['end'] - row['begin']
    data.append(row)

for o in data:
    try:
        res[o['node1']]['total'] += o['time']
        res[o['node1']]['effectif'] += 1
    except:
        res[o['node1']] = dict( total = o['time'], effectif = 1 )


for i in res.keys():
    res[i]['moyenne'] = res[i]['total'] / res[i]['effectif']

print res
