#Awk file to calculate instantaneous throughput
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data=0;

}

{
if($1=="r" && $7=="tcp" && $3=="_3_")
{

data += $8
print $2, data*8.0/$2/10000

}
}
END{
}

#To plot the output to the graph
#pipe the result to 'xgraph'

