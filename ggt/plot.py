#! /usr/bin/python
# -*- coding: utf-8 -*-

from pylab import *
from scipy import *

"""
Example of file io, reading and writing array files. Does csv format.
"""

data = genfromtxt('pwet.txt')
plot(data)
show()
