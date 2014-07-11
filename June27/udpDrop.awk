#Awk file to calculate instantaneous throughput
#To run awk file
#awk -f <awkfile> <tracefile>

BEGIN {
data=0;
firstData=0;
secondData=0;
thirdData=0;
}

{
	if($1=="d" && $5=="cbr")
	{
		data ++

	}
	if($1=="d" && $5=="cbr" && $8==1)
	{
		firstData += 1

	}
	if($1=="d" && $5=="cbr" && $8==2)
	{
		secondData += 1

	}
	if($1=="d" && $5=="cbr" && $8==3)
	{
		thirdData += 1

	}
}
END{
	print  "Total drop = "data
	print  "Drop at first = "firstData
	print  "Drop at second = "secondData
	print  "Drop at third = "thirdData
}

#To plot the output to the graph
#pipe the result to 'xgraph'

