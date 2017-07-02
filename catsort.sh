#!/bin/bash

cat "$@" >> temp && awk '!seen[$0]++' temp > temp2 && sort -o final temp2 && rm temp temp2




