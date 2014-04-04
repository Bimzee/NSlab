#Awk file to calculate instantaneous throughput
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data=0;
}

{
if($1=="d" && $5=="cbr")
{
data += 1

}
}
END{
print  data
}

#To plot the output to the graph
#pipe the result to 'xgraph'

