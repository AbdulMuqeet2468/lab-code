set ns [new Simulator]

$ns color 1 red

set nf [open dv.nam w]
$ns namtrace-all $nf

set tf [open dv.tr w]
$ns trace-all $tf

proc finish {} {
    global ns nf tf
    $ns flush-trace
    close $nf
    close $tf
    puts "running nam"
    exec nam dv.nam &
    exit 0
}

for {set i 0} {$i < 8} {incr i} {
    set n($i) [$ns node]
}

$n(0) label "Sender"
$n(3) label "Receiver"

for {set i 0} {$i < 7} {incr i} {
    $ns duplex-link $n($i) $n([expr ($i + 1) % 7]) 1Mb 10ms DropTail
}

$ns duplex-link $n(0) $n(7) 1Mb 10ms DropTail
$ns duplex-link $n(7) $n(3) 1Mb 10ms DropTail

$ns rtproto DV
$ns rtmodel-at 2.0 down $n(1) $n(2)
$ns rtmodel-at 2.4 up $n(1) $n(2)
$ns rtmodel-at 1.5 down $n(7) $n(3)
$ns rtmodel-at 2.5 up $n(7) $n(3)

set udp0 [new Agent/UDP]
$ns attach-agent $n(0) $udp0
$udp0 set fid_ 1

set null0 [new Agent/Null]
$ns attach-agent $n(3) $null0
$ns connect $udp0 $null0

set cbr0 [new Application/Traffic/CBR]
$cbr0 set packetSize_ 500
$cbr0 set interval_ 0.01
$cbr0 attach-agent $udp0

$ns at 0.5 "$cbr0 start"
$ns at 4.5 "$cbr0 stop"

$ns at 5.0 "finish"
$ns run