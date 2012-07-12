
set tf [open truc.tr w]
set ns [new Simulator]

$ns trace-all $tf
set aff_intervalle 1.0

set na [$ns node]
set nb [$ns node]


$ns simplex-link $na $nb 100Mb 0.0ms DropTail


set ag_video [new Agent/UDP]
$ag_video set fid_ 1
$ag_video set packetSize_ 1000

set ag_video_dst [new Agent/Null]

$ns attach-agent $na $ag_video
$ns attach-agent $nb $ag_video_dst
$ns connect $ag_video $ag_video_dst



set monitorna_nb [$ns makeflowmon Fid]
$ns attach-fmon [$ns link $na $nb] $monitorna_nb
set samples_object [new Samples]
$monitorna_nb set-delay-samples $samples_object

set fdescvideo [new QueueMonitor/ED/Flow]
set dsampvideo [new Samples]

$fdescvideo set-delay-samples $dsampvideo
set classif [$monitorna_nb classifier]
set slot2 [$classif installNext $fdescvideo]
$classif set-hash auto $ag_video $ag_video_dst 1 $slot2


proc affichedelais { } {
	global ns aff_intervalle monitorna_nb samples_object dsampvideo

	puts "toto [$ns now] [$monitorna_nb set parrivals_] [$samples_object mean] [$samples_object mean] [$dsampvideo cnt]"

	$ns at [expr [$ns now] + $aff_intervalle] "affichedelais"
}

set src_video [new Application/Traffic/Exponential]
$src_video set burst_time_ 1ms
$src_video set idle_time_ 2ms
$src_video set rate_ 30Mb
$src_video attach-agent $ag_video
$src_video set packet_size_ 1000

proc finish {} {
	global ns tr 
	affichedelais
	$ns flush-trace
	#close $tr
	exit 0
}

$ns at 0.0 "$src_video start"

$ns at 150.0 "finish"

$ns at $aff_intervalle "affichedelais"

$ns run

