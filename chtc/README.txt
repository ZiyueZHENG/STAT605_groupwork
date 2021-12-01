STEP1: Getting and clearning the data
All the data is in the package "archive.zip"
1. Using "unzip archive.zip -d raw_data/" to get the csv files(approximately 30GB in total).
2. Run clean_data.sh to extract the needed columns. Then your clean data is all under "data" folder.



STEP2: Using CHTC parallel jobs to extract the information in the data 
Run with following order:
1. clean.sh
2. getFilenames.sh
3. condor_submit bitcoin.sub

After all jobs done:
4. merge.sh

------------------------------------------------------------

Data description:
all_process.csv produced by merge.sh contains the following columns:

Date | Day of the week | Volume(Bitcon) | Turnover(USD) | Avg. Price(USD) | Opening Price(USD) | Closing Price(USD) | Max Price(USD) | Min Price(USD) | Net Inflow(Bitcon)
