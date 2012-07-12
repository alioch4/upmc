#!/usr/bin/env ns

# Protip: utiliser zo dans vim pour ouvrir les folds


# Le lien dsRED/edge a deux files physiques : 0 et 1
# La file physique 0 a deux files virtuelles : 0 et 1
# La file physique 1 n'a qu'une file virtuelle : 0
#
# On veut les fonctions suivantes :
# - Pas de controle de trafic à l'entrée : Null
# - Marquage et classification :
#   -flux de n1 -> nb : 10
#   -flux de n2 -> nb : 11
#   -flux de n3 -> nb : 12
#
# - Gestion tampon file 1 : DROP
# - Gestion tampon file 0 : RIO-C
# - Scheduling : WRR

# La topologie est la suivante :
#
# n1 --
#      \
# n2 ---+ na ---- nb
#      /
# n3 --

set ns [new Simulator]
#set tr [open "[% logfile %]" w]
#$ns trace-all $tr

# {{{ Configuration globale

# Intervalle pour relance_cbr
set int_rel_cbr 100.0

# Intervalle pour affichedelais
set aff_intervalle 10.0

# }}}

# {{{ Noeuds

set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set na [$ns node]
set nb [$ns node]

# }}}

# {{{ Liens 

$ns simplex-link $n1 $na 9999Mb 0.0ms DropTail
$ns simplex-link $n2 $na 9999Mb 0.0ms DropTail
$ns simplex-link $n3 $na 9999Mb 0.0ms DropTail
[% IF queue %]
$ns simplex-link $na $nb 100Mb 0.0ms dsRED/edge
[% ELSE %]
$ns simplex-link $na $nb 100Mb 0.0ms DropTail
[% END %]

$ns queue-limit $n1 $na 100000
$ns queue-limit $n2 $na 100000
$ns queue-limit $n3 $na 100000
$ns queue-limit $na $nb [% queue.size %]

# }}}

# {{{ Déclaration des files d'attente

set qnanb [[$ns link $na $nb] queue]

[% IF queue %]
# Nombre de files d'attente physiques
$qnanb set numQueues_ 1

# Nombre de files d'attente virtuelles au total
$qnanb setNumPrec 2

# L'information suivante est nécessaire pour éviter les divisions par 0
# Elle doit donc toujours être spécifiée

# ATTENTION À VOS FESSES ! (mais heu... no homo, hein)
# Cette valeur est à recalculer lorsqu'on traitera les questions sur DiffServ !
$qnanb meanPktSize 632.5

# Politique de marquage entre noeuds $n1 et $nb

$qnanb addPolicyEntry [$n1 id] [$nb id] Null 10
$qnanb addPolicyEntry [$n2 id] [$nb id] Null 11
$qnanb addPolicyEntry [$n3 id] [$nb id] Null 11

# Remarque : On peut utiliser plusieurs fois le même label

$qnanb addPolicerEntry Null 10
$qnanb addPolicerEntry Null 11
#$qnanb addPolicerEntry Null 12


# Arguments :
# 1X; File d'attente physique; File d'attente virtuelle
$qnanb addPHBEntry 10 0 0
$qnanb addPHBEntry 11 0 1
#$qnanb addPHBEntry 12 0 0

# Arguments :
# Politique; Numéro de la file à gestion de tampon RIO-C

$qnanb setMREDMode RIO-C 0
#$qnanb setMREDMode DROP 1

# Arguments :
# File d'attente physique; File d'attente virtuelle; min; max; Pmax
# Pmax : Probabilité max de suppression (Il faut prendre TOUJOURS 1)
$qnanb configQ 0 0 [% queue.size %] [% queue.size %] 1.0
$qnanb configQ 0 1 [% rioc.min ? rioc.min : 0 %] [% queue.size %] 1.0


# Si la somme des deux trafics (en moyenne) est comprise entre 10000
# et 20000 paquets, on supprime du trafic de la file 0 1
#$qnanb configQ 0 1 10000 20000 1.0

# Les deux dernières colonnes sont des paramètres factices
#$qnanb configQ 1 0 10000 12 0.12

[% IF queue.wrr %]
# Scheduling Weighted Round-Robin
$qnanb setSchedularMode WRR

# Arguments :
# File d'attente physique; Nombre de paquets consécutifs servis

$qnanb addQueueWeights 0 310
$qnanb addQueueWeights 1 50
[% END %]
[% IF queue.rr %]
# Scheduling Weighted Round-Robin
$qnanb setSchedularMode RR
[% END %]
[% IF queue.pri %]
# Priorité :

# Sert d'abord tous les paquets de la file 0 puis ceux de
# la file 1, etc...
$qnanb setSchedularMode PRI
[% END %]

# Autres configurations possibles
# (deux derniers arguments) Debit crête en bits/s; Taille tampon Leaky bucket en octet
# On s'intéresse ici aux débits instantannées et pas moyens
#$qnanb addPolicyEntry [$n1 id] [$nb id] TokenBucket 11 600000 75000

# Arguments :
# Label trafic conforme; Label trafic non conforme
#$qnanb addPolicyEntry TokenBucket 11 12
# ça se comporte comme une file finie à temps de service constant.
# Penser à traiter le trafic 12
# (ex: $qnanb configQ 0 1 0 0 1.0)

[% ELSE %]

$qnanb set numQueues_ 1

[% END %]

# }}} 

# {{{ Workaround relance_cbr (merci ns2)
proc relance_cbr { } {
	global ns src_voice ag_voice int_rel_cbr

	$src_voice stop
	delete $src_voice

	set src_voice [new Application/Traffic/CBR]

	# Tout le monde sait que le DRY c'est surfait.
	$src_voice set packet_size_ 100
	$src_voice set rate_ 20Mb
	$src_voice attach-agent $ag_voice
	$src_voice start

	$ns at [expr [$ns now] + $int_rel_cbr] "relance_cbr"
}

# Ne pas oublier de faire le premier appel

# }}}

# {{{ Agents

set ag_video [new Agent/UDP]
set ag_data [new Agent/UDP]
set ag_data2 [new Agent/UDP]
set ag_data3 [new Agent/UDP]
set ag_voice [new Agent/UDP]

$ag_video set fid_ 1
$ag_data set fid_ 2
$ag_data2 set fid_ 2
$ag_data3 set fid_ 2
$ag_voice set fid_ 3

set ag_video_dst [new Agent/Null]
set ag_data_dst [new Agent/Null]
set ag_data2_dst [new Agent/Null]
set ag_data3_dst [new Agent/Null]
set ag_voice_dst [new Agent/Null]

$ag_data set packetSize_ 50
$ag_data2 set packetSize_ 500
$ag_data3 set packetSize_ 1500
$ag_voice set packetSize_ 100
$ag_video set packetSize_ 1000

$ns attach-agent $n1 $ag_data
$ns attach-agent $n1 $ag_data2
$ns attach-agent $n1 $ag_data3
$ns attach-agent $n2 $ag_video
$ns attach-agent $n3 $ag_voice

$ns attach-agent $nb $ag_data_dst
$ns attach-agent $nb $ag_data2_dst
$ns attach-agent $nb $ag_data3_dst
$ns attach-agent $nb $ag_video_dst
$ns attach-agent $nb $ag_voice_dst

$ns connect $ag_data $ag_data_dst
$ns connect $ag_data2 $ag_data2_dst
$ns connect $ag_data3 $ag_data3_dst
$ns connect $ag_video $ag_video_dst
$ns connect $ag_voice $ag_voice_dst

# }}}

# {{{ Bouts de code pour le monitoring des files d'attente

set monitorna_nb [$ns makeflowmon Fid]
$ns attach-fmon [$ns link $na $nb] $monitorna_nb
set samples_object [new Samples]
$monitorna_nb set-delay-samples $samples_object

set fdescvideo [new QueueMonitor/ED/Flow]
set dsampvideo [new Samples]

$fdescvideo set-delay-samples $dsampvideo
set classif [$monitorna_nb classifier]

# Avant dernier argument => fid
$classif set-hash auto $ag_video $ag_video_dst 1 [$classif installNext $fdescvideo]

# Monitoring données
set fdescdonnees [new QueueMonitor/ED/Flow]
set dsampdonnees [new Samples]

$fdescdonnees set-delay-samples $dsampdonnees

$classif set-hash auto $ag_data $ag_data_dst 2 [$classif installNext $fdescdonnees]
$classif set-hash auto $ag_data2 $ag_data2_dst 2 [$classif installNext $fdescdonnees]
$classif set-hash auto $ag_data3 $ag_data3_dst 2 [$classif installNext $fdescdonnees]

# Monitoring voix
set fdescvoix [new QueueMonitor/ED/Flow]
set dsampvoix [new Samples]

$fdescvoix set-delay-samples $dsampvoix

$classif set-hash auto $ag_voice $ag_voice_dst 3 [$classif installNext $fdescvoix]

# Procédure pour afficher le taux de pertes
proc affichepertes { } {
	global ns aff_intervalle monitorna_nb fdescvideo fdescdonnees fdescvoix

	puts "[$ns now] [$monitorna_nb set pdrops_] \
		[$monitorna_nb set parrivals_] \
		[$fdescvideo set pdrops_] \
		[$fdescvideo set parrivals_] \
		[$fdescdonnees set pdrops_] \
		[$fdescdonnees set parrivals_] \
		[$fdescvoix set pdrops_] \
		[$fdescvoix set parrivals_]"

	$ns at [expr [$ns now] + $aff_intervalle] "affichepertes"
}

# Procédure pour afficher le bousin
proc affichedelais { } {
	global ns aff_intervalle monitorna_nb samples_object dsampvideo dsampdonnees dsampvoix

	set mean_delay_all [expr [$samples_object mean] + 234 * 8.0 / 100000000]
	set mean_delay_video [expr [$dsampvideo mean] + 800 * 1.0 / 100000000]
	set mean_delay_voice [expr [$dsampvoix mean] + 8000 * 1.0 / 100000000]
	set mean_delay_data [expr [$dsampdonnees mean] + 4960 * 1.0 / 100000000]

	puts "[$ns now] [$monitorna_nb set pdrops_] \
		[$monitorna_nb set parrivals_] \
		$mean_delay_all \
		$mean_delay_video \
		$mean_delay_data \
		$mean_delay_voice"

	$dsampvideo reset
	$dsampdonnees reset
	$dsampvoix reset
	$samples_object reset

	$ns at [expr [$ns now] + $aff_intervalle] "affichedelais"
}

# }}}

# {{{ Applications

# {{{ Trafic data, packetSize = 50 B
set src_data1 [new Application/Traffic/Exponential]
$src_data1 set burst_time_ 0.0ms
$src_data1 set idle_time_ 0.41ms
$src_data1 set rate_ 9999Mb
$src_data1 set packetSize_ 50
$src_data1 attach-agent $ag_data
# }}}

# {{{ Trafic data, packetSize = 500 B
set src_data2 [new Application/Traffic/Exponential]
$src_data2 set burst_time_ 0.0ms
$src_data2 set idle_time_ 0.55ms
$src_data2 set rate_ 9999Mb
$src_data2 set packetSize_ 500
$src_data2 attach-agent $ag_data2
# }}}

# {{{ Trafic data, packetSize = 1500 B
set src_data3 [new Application/Traffic/Exponential]
$src_data3 set burst_time_ 0.0ms
$src_data3 set idle_time_ 0.55ms
$src_data3 set rate_ 9999Mb
$src_data3 set packetSize_ 1500
$src_data3 attach-agent $ag_data3
# }}}

# {{{ Trafic voix
set src_voice [new Application/Traffic/CBR]
$src_voice set packetSize_ 100
$src_voice set rate_ 20Mb
$src_voice attach-agent $ag_voice
# }}}

# {{{ Trafic vidéo
set src_video [new Application/Traffic/Exponential]
$src_video set burst_time_ 1ms
$src_video set idle_time_ [% video.burstiness ? (video.burstiness - 1) : 2 %]ms
$src_video set rate_ [% video.burstiness ? (video.burstiness * 30) : 90 %]Mb
$src_video set packetSize_ 1000
$src_video attach-agent $ag_video
# }}}

# }}}

# {{{ Cleanup

proc finish {} {
	global ns tr 
	affichepertes
	$ns flush-trace
	#close $tr
	exit 0
}

# }}}

# {{{ Planification

$ns at 0.0 "$src_data1 start"
$ns at 0.0 "$src_data2 start"
$ns at 0.0 "$src_data3 start"
$ns at 0.0 "$src_voice start"
$ns at 0.0 "$src_video start"

$ns at 150.0 "finish"

$ns at $int_rel_cbr "relance_cbr"
$ns at $aff_intervalle "affichepertes"

puts "#Time Drops Recvd MeanDelayAll MeanDelayVideo MeanDelayData MeanDelayVoice"

# }}}

$ns run

# vi:fdm=marker:ft=tcl:
