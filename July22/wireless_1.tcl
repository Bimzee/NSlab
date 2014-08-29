
#declare variables used for configuring wirelss nodes in NS
set val(chan) Channel/WirelessChannel
set val(prop) Propagation/TwoRayGround
set val(netif) Phy/WirelessPhy
set val(mac) Mac/802_11
set val(ifq) Queue/DropTail/PriQueue
set val(ll) LL
set val(ant) Antenna/OmniAntenna
set val(ifqlen) 50
set val(rp) DSDV
set val(nn) 5

set ns [new Simulator]
set tf [open wireless.tr w]
$ns trace-all $tf

set tf1 [open wireless1.nam w]
$ns namtrace-all-wireless $tf1 700 700

set topo [new Topography]
$topo load_flatgrid 700 700
#General Operations Director --used for storing intermediate node movement
create-god $val(nn)

#give  proper configuratons 
$ns node-config -adhocRouting $val(rp) \
-llType $val(ll) \
-macType $val(mac) \
-ifqType  $val(ifq) \
-ifqLen $val(ifqlen) \
-antType $val(ant) \
-propType $val(prop) \
-phyType $val(netif) \
-channelType $val(chan) \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON \
-macTrace OFF \
-movementTrace OFF


set node0 [$ns node]
set node1 [$ns node]
set node2 [$ns node]
set node3 [$ns node]
set node4 [$ns node]

$ns initial_node_pos $node0 30
$ns initial_node_pos $node1 30
$ns initial_node_pos $node2 30
$ns initial_node_pos $node3 30
$ns initial_node_pos $node4 30



$node0 set X_ 1.0
$node0 set Y_ 250.0
$node0 set Z_ 0.0

$node1 set X_ 1.0
$node1 set Y_ 1.0
$node1 set Z_ 0.0

$node2 set X_ 300.0
$node2 set Y_ 300.0
$node2 set Z_ 0.0

$node3 set X_ 250.0
$node3 set Y_ 250.0
$node3 set Z_ 0.0

$node4 set X_ 250.0
$node4 set Y_ 1.0
$node4 set Z_ 0.0



set tcp0 [new Agent/TCP]
$ns attach-agent $node0 $tcp0

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

set  sink  [new Agent/TCPSink]
$ns attach-agent $node3 $sink

$ns connect $tcp0 $sink

set tcp1 [new Agent/TCP]
$ns  attach-agent $node1 $tcp1

set ftp1 [new Application/Traffic/CBR]
$ftp1 attach-agent $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $node4 $sink1

$ns connect $tcp1 $sink1


$ns at 0.0 "$node0 setdest 1.0 250.0 20.0"
$ns at 0.0 "$node1 setdest 1.0 1.0 20.0"
$ns at 0.0 "$node2 setdest 300.0 300.0 20.0"
$ns at 0.0 "$node3 setdest 250.0 250.0 20.0"
$ns at 0.0 "$node4 setdest 250.0 1.0 20.0"

$ns at 30.0 "$node3 setdest 275.0 250.0 20.0"
$ns at 30.0 "$node4 setdest 275.0 1.0 20.0"
$ns at 30.0 "$node2 setdest 135.0 125.0 20.0"

$ns at 5.0 "$ftp0 start"
$ns at 300.0 "$ftp0 stop"
$ns at 6.0 "$ftp1 start"
$ns at 300.0 "$ftp1 stop"
$ns at 301.0 "finish"

proc finish { } {

exit 0
}
$ns run
