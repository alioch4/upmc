#!/usr/bin/python
# -*- coding: utf8 -*-

from __future__ import division
import csv
from collections import defaultdict
from string import strip
from numpy import *


def striplist(l):
    return([x.strip() for x in l])

f = csv.reader(open('component.tab','r'),delimiter='\t')
output = open('seti-output.txt','w')

values = ['component_id', 'node_id', 'platform_id', 'creator_id', 'node_name',
        'component_type', 'trace_start', 'trace_end', 'resolution']
data = list()
res = list()

for row in f:
    row = dict(zip(values,striplist(row)))
    row['trace_start'] = float(row['trace_start'])
    row['trace_end'] = float(row['trace_end'])

    row['time'] = row['trace_end'] - row['trace_start']
    data.append(row)

for o in data:
    res.append(o['time'])

num_data = array(res)
mean = num_data.mean()
std = num_data.std()

for o in data:
    o['normalized_time'] = ( o['time'] - mean ) / std

data_sorted = sorted(data, key=lambda k: k['normalized_time']) 
for item in data_sorted:
    print "%s %s\n" % (item['time'], item['normalized_time'] )
    output.write("%s, %s\n" % (item['time'], item['normalized_time']))


