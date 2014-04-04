#Awk file to calculate instantaneous throughput
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data=0;
}

{
if($1=="d" && $4=="1" && $5=="cbr")
{
data += $6

}
}
END{
print $2, data*8.0/$2/10000
}

#To plot the output to the graph
#pipe the result to 'xgraph'

