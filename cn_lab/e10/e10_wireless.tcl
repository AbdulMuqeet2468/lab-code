set ns [new Simulator]

set topo
$topo load_flatgrid $val(x) $val(y)
create-god $val(nm)

set tracefile [open wireless.tr w]
$ns trace-all $tracefile

set namfile [open wireless.nam w]
$ns namtrace-all $namfile
$ns namtrace-all-wireless $namfile $val(x) $val(y)

set chon [new $val(chon)];

set n0 [$ns node]
$n0 set X_275
$n0 set Y_422
$n0 set Z_0.0
$ns initial_node_pos $n0 20

set n1 [$ns node]
$n1 set X_356
$n1 set Y_209
$n1 set Z_0.0
$ns initial_node_pos $n1 20

set n2 [$ns node]
$n2 set X_677
$n2 set Y_430
$n2 set Z_0.0
$ns initial_node_pos $n2 20

set n3 [$ns node]
$n3 set X_772
$n3 set Y_229
$n3 set Z_0.0
$ns initial_node_pos $n3 20

set n4 [$ns node]
$n4 set X_509
$n4 set Y_282
$n4 set Z_0.0
$ns initial_node_pos $n4 20

set n5 [$ns node]
$n5 set X_472
$n5 set Y_491
$n5 set Z_0.0
$ns initial_node_pos $n5 20

set n6 [$ns node]
$n6 set X_625
$n6 set Y_212
$n6 set Z_0.0
$ns initial_node_pos $n6 20

set n7 [$ns node]
$n7 set X_837
$n7 set Y_448
$n7 set Z_0.0
$ns initial_node_pos $n7 20

set n8 [$ns node]
$n8 set X_907
$n8 set Y_261
$n8 set Z_0.0
$ns initial_node_pos $n8 20

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink1 [new Agent/TCPSink]
$ns attach-agent $n7 $sink1
$ns connect $tcp0 $sink1
$tcp0 set packetSize_1500

set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 1.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"

proc finish{}{
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam wireless.nam &
    exit 0
}

for {set i 0}{$i < $val(nn)}{incr i}{
    $ns at $val(stop) "\$n $i reset"
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run