set stop 21.0
set ns [new Simulator]

set a 5
$ns color 1 Magenta

set tracefile [open mesh.tr w]
$ns trace-all $tracefile

set namfile [open mesh.nam w]
$ns namtrace-all $namfile

for {set i 0} {$i < $a} {incr i} {
    set n($i) [$ns node]
}

for {set i 0} {$i < [expr $a - 1]} {incr i} {
    for {set j [expr $i + 1]} {$j < $a} {incr j} {
        $ns duplex-link $n($i) $n($j) 512kb 5ms DropTail
    }
}

set tcp0 [new Agent/TCP]
$ns attach-agent $n(0) $tcp0
$tcp0 set class_ 1
$tcp0 set packetSize_ 1500

set sink1 [new Agent/TCPSink]
$ns attach-agent $n(3) $sink1
$ns connect $tcp0 $sink1

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 1.0 "$ftp0 start"
$ns at 20.0 "$ftp0 stop"

proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam mesh.nam &
    exit 0
}

$ns at $stop "finish"
$ns run