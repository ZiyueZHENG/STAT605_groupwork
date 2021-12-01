Run with following order:

1. clean.sh
2. getFilenames.sh
3. condor_submit bitcoin.sub

After all jobs done:
4. merge.sh

------------------------------------------------------------

Data description:
all_process.csv produced by merge.sh contains the following columns:

Date | Volume | Turnover | Avg. Price | Opening Price | Closing Price | Max Price | Min Price | Net Inflow
