#!/bin/bash

#take the complement of '[:alpha:]' (i.e. special characters and spaces) and delete them
#count the number of alphabetical characters

tr -cd '[:alpha:]' < $1 | wc -m
