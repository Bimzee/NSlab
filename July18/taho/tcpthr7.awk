#Awk file to calculate throughput @ node 7 using tcp taho
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data = 0;
}

{
#calculate throughput for node7
if($1=="r" && $4=="7" && $5=="tcp")
{
data += $6
print $2, data*8.0/$2/10000
}
}
END{
}

#redirect the output to a specific .dat file
#To plot the output to the graph
#pipe the result to 'xgraph'

