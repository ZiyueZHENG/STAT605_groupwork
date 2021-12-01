#!/bin/bash


for i in $(ls raw_data)
do
  cat raw_data/$i | tail -n +2 | cut -d, -f 3,4,5 > data/clean_$i;
  rm raw_data/$i;
done

