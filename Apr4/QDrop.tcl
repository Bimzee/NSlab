#create Simulator object
set ns [new Simulator]

set f1 [open queuedrop.tr w]
$ns namtrace-all $f1

set f2 [open queuedrop.nam w]
$ns namtrace-all $f2

proc finish{
}
{
exit 0
}

#creating nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]

#create link. Here we use duplex link
$ns duplex-link $n0 $n3 1Mb 10ms DropTail #Set link b/n node0 & node3
$ns duplex-link $n1 $n3 1Mb 10ms DropTail
$ns duplex-link $n2 $n3 1Mb 10ms DropTail
$ns duplex-link $n3 $n4 1Mb 10ms DropTail #Set link b/n node3 & node4
$ns duplex-link $n4 $n5 1Mb 10ms DropTail #Set link b/n node4 & node5
$ns duplex-link $n4 $n6 1Mb 10ms DropTail
$ns duplex-link $n4 $n7 1Mb 10ms DropTail

#Creating the protocol agents of source
set udp0 [new Agent/UDP] #proto agents ovewr here are UDP
$ns attach-agent $n0 $udp0 #attaching agents to node

set udp1 [new Agent/UDP]
$ns attach-agent $n1 $udp1

set udp2 [new Agent/UDP]
$ns attach-agent $n2 $udp2
#all source agents created

#creating proto agents of Dest
#udp dest is set as Null. creating dest agents
set null5 [new Agent/Null] #Dest agent is udp and it is null
$ns attach-agent $n5 $null5

set null6 [new Agent/Null]
$ns attach-agent $n6 $null6

set null7 [new Agent/Null]
$ns attach-agent $n7 $null7
#all Dest agents created

#Creating the user applications. Here the user app is CBR
set cbr0 [new Application/Traffic/CBR]
$cbr0 attach-agent $udp0

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp1

set cbr2 [new Application/Traffic/CBR]
$cbr2 attach-agent $udp2

#Connecting different source and Destinations
$ns connect $udp0 $null5  #Connect n0 to n5
$ns connect $udp1 $null6  #Connect n1 to n6
$ns connect $udp2 $null7  #Connect n2 to n7

#Set flowid values since we are using UDP
$udp0 set fid_ 1
$udp1 set fid_ 2
$udp2 set fid_ 3

#start the applications
$ns at 0.5 "cbr0 start"
$ns at 0.5 "cbr1 start"
$ns at 2.0 "cbr2 start"

$ns at 3.0 "cbr2 stop"
$ns at 10.0 "cbr0 stop"
$ns at 10.0 "cbr1 stop"

$ns at 10.1 "finish"

$ns run
