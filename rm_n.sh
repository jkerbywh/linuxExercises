#!/bin/bash
echo "./rm_n.sh <dir> <n>" 1>&2
find $1 -type f -size +$2c -exec rm {} \;
