#!/bin/bash

ls ./data | sed -e 's/clean_//g' -e 's/.csv//g' > filenames.txt

