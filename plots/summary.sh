#!/bin/bash

R CMD BATCH R/summary.R
cat summary.Rout | grep "[1]" | grep -v "+" | grep -v ">" | grep -v version | grep -v Copyright
