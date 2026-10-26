set ns [new Simulator]

set tf [open sandw.tr w]
$ns trace-all $tf

set nf [open sandw.nam w]
$ns nam trace-all $nf

$ns color 1 violet

proc finish{}{
    global ns tf nf
    $ns flush-trace
    close $tf 
    close $nf
    exec nam sandw.nam &
    exit 0
}

set n0 [$ns node]
$n0 label "Transmitter"
$n0 color red
$n0 shape square

set n1 [$ns node]
$n1 label "Reciever"
$n1 color chocolate

$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link-op $n0 $n1 orient right
$ns duplex-link-op $n0 $n1 color chocolate
$ns duplex-link-op $n0 $n1 label "link-n"

set tcp0 [new Agent/TCP]
$tcp0 set window_4  
$ns attach-agent $n0 $tcp0
$tcp0 set fid_1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0 
set sink0 [new Agent/TCPSink]
$ns attach-agent $n1 $sink0
$ns connect $tcp0 $sink0

$ns at 0.2 "$ftp0 start"
$ns at 2.5 "$ftp0 stop"
$ns at 2.52 "finish"

$ns run