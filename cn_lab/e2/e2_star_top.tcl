set ns [new Simulator]

set nf [open star.nam w]
$ns namtrace-all $nf

set tf [open star.tr w]
$ns trace-all $tf

$ns color 1 orange

proc finish{}{
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    exec nam star.nam &
    exit 0
}

for {set i 0}{$i < 6}{incr i 1}{
    set n($i) [$ns node]
}

$n(0) shape square
$n(0) color Magenta
$n(0) label Hub

for {set i 1}{$i < 6}{incr i 1}{
    $ns duplex-link $n(0) $n($i) 1Mb 10ms DropTail
}

set tcp0 [new Agent/TCP]
$tcp0 set class_1
$ns attach-agent $n(1) $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink0
$ns connect $tcp0 $sink0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_500
$cbr0 set interval_0.01
$cbr0 attach-agent $tcp0

$ns rtmodel-at 1.5 down $n(0)
$ns rtmodel-at 2.5 up $n(0)

$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 5.0 "finish"
$ns run