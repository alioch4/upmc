proc simulation { file b d } {
  set ns [new Simulator]
  set tf [open $file w]
  $ns trace-all $tf
  # Création des noeuds
  set n0 [$ns node]
  set n1 [$ns node]

  # Création des agents
  set tcp1 [new Agent/TCP/RFC793edu]
  $tcp1 set packetSize_ 125

  set tcp2 [new Agent/TCPSink]

  # Création des liens
  $ns duplex-link $n0 $n1 $b $d DropTail

  # Attachement des agents aux noeuds
  $ns attach-agent $n0 $tcp1
  $ns attach-agent $n1 $tcp2

  # Connexion
  $ns connect $tcp1 $tcp2
  $ns queue-limit $n0 $n1 5

  # Paramètres temporels
  $ns at 0.0 "$tcp1 send 1500000"
  $ns at 100000 "$ns flush-trace; close $tf; exit 0"

  $ns run
}

simulation [lindex $argv 0] [lindex $argv 1] [lindex $argv 2]
