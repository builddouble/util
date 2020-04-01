#!/bin/bash

STRING="$1"
NUM=`echo $STRING | sed -e 's/[^0-9]//g'`
echo $NUM
