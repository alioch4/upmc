set ns [new Simulator]
set nf [open out.nam w]
set tf [open out.tr w]

$ns namtrace-all $nf
$ns trace-all $tf

proc finish {} {
	global ns nf tf
	$ns flush-trace
	close $nf
	close $tf
	exec nam out.nam &
	exit 0
}


# Noeuds
set n0 [$ns node]
set n1 [$ns node]

# Lien duplexe entre n0 et n1
$ns duplex-link $n0 $n1 1Mb 10ms DropTail

# Agents
#
# Les agents modélisent la couche transport.

set udp1 [new Agent/UDP]
$udp1 set packetSize_ 125

set udp2 [new Agent/Null]

$ns attach-agent $n0 $udp1
$ns attach-agent $n1 $udp2

$ns connect $udp1 $udp2

# Applications
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packet_size_ 125
$cbr1 set rate_ 192.0Kb
$cbr1 set random_ 1

$cbr1 attach-agent $udp1

$ns at 1.0 "$cbr1 start"
$ns at 5.0 "$cbr1 stop"

$ns at 5.0 "finish"

$ns run
