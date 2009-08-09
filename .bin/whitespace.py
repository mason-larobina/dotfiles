#!/usr/bin/env python

import sys
import os

def strip(raw):
    lines = [s.rstrip() for s in raw.strip().split("\n")]
    raw = '\n'.join(lines)
    while "\n\n\n\n" in raw:
        raw = raw.replace("\n\n\n\n", "\n\n\n")

    return raw

if __name__ == "__main__":
    
    if not len(sys.argv[1:]):
        print "usage: whitespace.py [input-filename] {optional-output-location}"
        sys.exit(1)
    
    filename = sys.argv[1]
    h = open(filename, 'r')
    s = h.read()
    h.close()
    
    raw = "%s\n" % strip(s)

    if len(sys.argv[2:]):
        h = open(sys.argv[2], 'w')
        h.write(raw)
        h.close()
    
    else:
        print raw


