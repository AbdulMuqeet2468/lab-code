set ns [new Simulator]
$ns color 1 Violet
$ns color 2 Red

set nf [open bus.nam w]
$ns namtrace-all $nf

set tf [open bus.tr w]
$ns trace-all $tf

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam bus.nam &
    exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

set lan0 [$ns newLan "$n0 $n1 $n2 $n3 $n4" 1.5Mb 40ms LL Queue/DropTail MAC/CSMA/Cd channel]

set tcp0 [new Agent/TCP]
$tcp0 set fid_ 1
$ns attach-agent $n1 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp0
$ftp3 set type_ FTP

set udp4 [new Agent/UDP]
$ns attach-agent $n2 $udp4
set null3 [new Agent/Null]
$ns attach-agent $n4 $null3
$ns connect $udp4 $null3
$udp4 set fid_ 2

set cbr1 [new Application/Traffic/CBR]
$cbr1 set packetSize_ 1050
$cbr1 set interval_ 0.005
$cbr1 attach-agent $udp4

$ns at 0.5 "$ftp3 start"
$ns at 4.0 "$ftp3 stop"
$ns at 1.5 "$cbr1 start"
$ns at 5.0 "finish"
$ns run