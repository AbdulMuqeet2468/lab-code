set ns [new Simulator]

$ns color 1 red

set nf [open sr.nam w]
$ns namtrace-all $nf

set tf [open sr.tr w]
$ns trace-all $tf

proc finish{}{
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam sr.nam &
    exit 0
}

for {set i 0}{$i < 8}{incr i}{
    set n($i) [$ns node]
}

$n(0) label "Sender"
$n(3) label "Reciever"

for {set i 0}{$i < 7}{incr i}{
    $ns duplex-link $n($i) $n([expr($i + 1) % 7]) 1Mb 10ms DropTail
}

$ns duplex-link $n(0) $n(7) 1Mb 10ms DropTail
$ns duplex-link $n(7) $n(3) 1Mb 10ms DropTail

$ns cost $n(0) $n(7) 8
$ns cost $n(7) $n(3) 2
$ns cost $n(0) $n(1) 5
$ns cost $n(1) $n(2) 2
$ns cost $n(2) $n(3) 2
$ns cost $n(3) $n(4) 3
$ns cost $n(4) $n(5) 2
$ns cost $n(5) $n(6) 1
$ns cost $n(6) $n(0) 2

$ns rtmodel-dt 1.0 down $n(5) $n(6)
$ns rtmodel-dt 1.2 up $n(5) $n(6)
$ns rtmodel-dt 1.5 down $n(4) 
$ns rtmodel-dt 2.5 up $n(4) 

set udp0 [new Agent/UDP]
$udp0 set fid_1
$ns attach-agent $n(0) $udp0

set null0 [new Agent/Null]
$ns attach-agent $n(0) $null0
$ns connect $udp0 $null0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_500
$cbr0 set interval_0.01
$cbr0 attach-agent $udp0

$ns at 0.5 "cbr0 start"
$ns at 4.5 "cbr0 stop"

$ns at 5.0 "finish"
$ns run