# Estimation d'un taux de perte et de son intervalle de confiance

# 2012-02-07 (c) x0r <x0r@x0r.fr>

set ns [new Simulator]
set tf [open tcp2.tr w]

proc finish {} {
	global ns tf
	$ns flush-trace
	exit 0
}

set n_arr 0
set n_perte 0
set n_arr_bloc 0
set n_perte_bloc 0

proc act { a } {
	global n_arr n_perte

	set x [lindex $a 0]
	set t [lindex $a 1]
	if { $x == "+" } {
		set n_arr [expr $n_arr + 1]
	} elseif { $x == "d" } {
		set n_perte [expr $n_perte + 1]
	}

#	if { $x == "+" || $x == "d" } {
#		if { $n_arr > 0 } {
#			set taux_perte [expr $n_perte * 1.0 / $n_arr]
#			puts "$t $taux_perte"
#		}
#	}
}


proc moy { t } {
	global n_arr n_perte n_arr_bloc n_perte_bloc


	# Calcul du nombre d'arrivées et de pertes dans le bloc
	set n_arr_bloc [expr $n_arr - $n_arr_bloc]
	set n_perte_bloc [expr $n_perte - $n_perte_bloc]

	# Calcul des moyennes
	set moy_globale [expr $n_perte * 1.0 / $n_arr]
	set moy_bloc [expr $n_perte_bloc * 1.0 / $n_arr_bloc]

	# Réinitialisation du bloc
	set n_arr_bloc $n_arr
	set n_perte_bloc $n_perte

	puts "$t $moy_globale $moy_bloc"
}



# Noeuds 
set n0 [$ns node]
set n1 [$ns node]

# Lien entre n0 et n1
$ns duplex-link $n0 $n1 512Kb 1ms DropTail
$ns queue-limit $n0 $n1 5

# Callback
[$ns link $n0 $n1] trace-callback $ns "act"

# Agents
set tcp1 [new Agent/TCP]
set tcp2 [new Agent/TCPSink]

set udp1 [new Agent/UDP]
set udp2 [new Agent/Null]

$tcp1 set packetSize_ 125
$udp1 set packetSize_ 125

$ns attach-agent $n0 $tcp1
$ns attach-agent $n1 $tcp2
$ns attach-agent $n0 $udp1
$ns attach-agent $n1 $udp2

$ns connect $tcp1 $tcp2
$ns connect $udp1 $udp2

# Application
set cbr1 [new Application/Traffic/CBR]
$cbr1 set packet_size_ 125
$cbr1 set rate_ 192.0Kb
$cbr1 set random_ 1

$cbr1 attach-agent $udp1

$ns at 0.0 "$tcp1 send 1500000"
$ns at 0.0 "$cbr1 start"
$ns at 250.0 "$cbr1 stop"

for { set i 10.0 } { $i <= 100.0 } { set i [expr $i + 10.0] } {
	$ns at $i "moy $i"
}

$ns at 100.0 "finish"

$ns run
