#!/bin/bash

for x in {1..4}; do for y in {1..4}; do openscad -D x=$x -D y=$y -o stanley_bin_${x}x${y}.stl stanley_bin.scad ; done; done
