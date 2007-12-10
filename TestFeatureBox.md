#acl All:
#{{attachment:test.py}}

{{{#!python
from string import whitespace
from math import *
from math import sin as SIN
from math import cos as COS

l = [(1, 1), (2, 4), (3, 9), (4, 16), (5, 25)]
for x, xsquared in l:
    print x, ':', xsquared

try:
    theFile = open("the_parrot")
 except IOError, (ErrorNumber, ErrorMessage):
     if ErrorNumber == 2: # file not found
        print "Sorry, 'the_parrot' has apparently joined the choir invisible."
     else:
        print "Congratulation! you have managed to trip a #%d error" % ErrorNumber  # String concatenation is slow, use % formatting whenever possible
        print ErrorMessage

def make_dictionary(max_length = 10, **entries):
    return dict([(key, entries[key]) for i, key in enumerate(entries.keys()) if i < max_length])
}}}
