#!/bin/bash

awk -F, 'BEGIN{
			maxPrice = 0; 
			minPrice = 99999;
			totalBuy = 0;
			totalSell = 0;
		} 
		{
			if (NR == 1) {
				startPrice = $3
			}
			volume += $2/1000000; 
			turnover += ($2*$3)/1000000; 
			if ($3 > maxPrice) {
				maxPrice = $3
			}; 
			if ($3 < minPrice) {
				minPrice = $3
			};
			if ($1 == "Buy") {
				totalBuy += $2;
			} else {
				totalSell += $2;
			}
		}
		END{
			print FILENAME","volume","turnover","turnover/volume","startPrice","$3","maxPrice","minPrice","totalBuy-totalSell
			}' clean_BTCUSD2019-11-26.csv | 

sed -e s/clean_BTCUSD//g -e s/.csv//g > ./processed_BTCUSD2019-11-26.csv

