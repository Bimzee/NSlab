#Awk file to calculate instantaneous throughput
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data = 0;
}

{
if($1=="r" && $4=="5" && $5=="tcp")
{
data += $6
print $2, data*8.0/$2/10000
}
}
END{
}

#To plot the output to the graph
#pipe the result to 'xgraph'

