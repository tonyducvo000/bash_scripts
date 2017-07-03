#!/bin/bash

tr -cd '[:alpha:]' < $1 | wc -m
