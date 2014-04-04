#create Simulator object
set ns [new Simulator]

#create Trace Object
set tr [open Sample.tr w]
$ns trace-all  $tr

#Create NAM object
set nm [open first.nam w]
$ns namtrace-all $nm

#create node
set n0 [$ns node]
set n1 [$ns node]

#create link. Here we use duplex link
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

#Create proto Agent to the source
set tcp0 [new Agent/TCP]
#Attach agent to source
$ns attach-agent $n0 $tcp0 

#Create proto agent to sink/ Dest
set sink0 [new Agent/TCPSink]
#Attach agent to Dest
$ns attach-agent $n1 $sink0 

#Create application of FTP
set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

proc finish {} { puts "complete"; exit 0 }

#set connection for source and sink
$ns connect $tcp0 $sink0

#start the application of ftp at the time .5
$ns at 0.5 "$ftp0 start"
$ns at 4.5 "$ftp0 stop"

$ns at 5.0 "finish"

$ns run
