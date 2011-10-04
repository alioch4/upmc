#!/usr/bin/python
# -*- coding: utf8 -*-

from __future__ import division
import csv
from collections import defaultdict
from string import strip
from numpy import *

def striplist(l):
    return([x.strip() for x in l])
fichier = open('component.tab','r')

f = csv.reader(fichier, delimiter='\t')
output = open('seti-output.txt','w')

values = ['component_id',
        'node_id', 'platform_id',
        'creator_id', 'node_name',
        'component_type', 'start',
        'end', 'resolution']
data = list()
res = list()

for row in f:
    row = dict(zip(values,striplist(row)))
    row['start'] = float(row['start'])
    row['end'] = float(row['end'])

    row['time'] = row['end'] - row['start']
    data.append(row)

for o in data:
    res.append(o['time'])

num_data = array(res)
mean = num_data.mean()
std = num_data.std()

for o in data:
    o['nrml_time']=(o['time']-mean)/std

data_sorted=sorted(data,
        key=lambda k: k['nrml_time'])
for i in data_sorted:
    print "%s %s\n"%(i['time'],i['nrml_time'])
    output.write("%s, %s\n" % 
            (i['time'], i['nrml_time']))

