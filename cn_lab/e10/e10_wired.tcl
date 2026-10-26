set ftp0 [new Application/FTP]
$ftp0 attach-agent $tcp0

$ns at 1.0 "$ftp0 start"
$ns at 2.0 "$ftp0 stop"

set cbr1 [new Application/Traffic/CBR]
$cbr1 attach-agent $udp2
$cbr1 set packetSize_1000
$cbr1 set rate_1.0Mb
$cbr1 set random_null

$ns at 1.0 "$cbr1 start"
$ns at 2.0 "$cbr1 stop"

proc finish{}{
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    exec nam w1.nam &
    exit 0
}

$ns at $val(stop) "$ns nam-end-wireless $val(stop)"
$ns at $val(stop) "finish"
$ns at $val(stop) "puts \"done\" ; $ns halt"
$ns run 