#Awk file to calculate instantaneous throughput
#awk -f <awkfile> <tracefile>

BEGIN {
data=0;
}

{
if($1=="r" && $4=="1" && $5=="tcp")
{
data += $6
print $2, data*8.0/$2/1000000
}
}
END{
}

