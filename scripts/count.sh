#!/bin/bash

echo "0" > cnt.txt
echo $CNT
for i in `seq $1`
do
    CNT=`cat cnt.txt`
    
    CNT=$(($CNT + 1))
    echo $CNT > cnt.txt
    echo $CNT
done