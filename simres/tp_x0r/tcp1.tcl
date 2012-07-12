# Simulation de TCP (RFC 793)
#
# 2012-02-07 (c) x0r <x0r@x0r.fr>


# Questions :
#
# 2. 6,2 ko/s
# 3. C'est dû au temps que le ack d'un paquet revienne à l'émetteur.  L'émetteur
# n'envoie pas de nouveau paquet avant d'avoir reçu le ack du paquet précédent.

# Avec le modèle TCP Tahoe, c'est pas mieux.

set ns [new Simulator]
set tf [open tcp1-tahoe.tr w]

$ns trace-all $tf

proc finish {} {
	global ns tf
	$ns flush-trace
	close $tf
	exit 0
}


# Noeuds
set n0 [$ns node]
set n1 [$ns node]

# Lien entre n0 et n1
$ns duplex-link $n0 $n1 50Mb 200ms DropTail
$ns queue-limit $n0 $n1 5

# Agents
set tcp1 [new Agent/TCP/RFC793edu]
#set tcp1 [new Agent/TCP]
$tcp1 set packetSize_ 125

set tcp2 [new Agent/TCPSink]

$ns attach-agent $n0 $tcp1
$ns attach-agent $n1 $tcp2

$ns connect $tcp1 $tcp2

# Application
$ns at 0.0 "$tcp1 send 1500000"

$ns at 100000.0 "finish"

$ns run
