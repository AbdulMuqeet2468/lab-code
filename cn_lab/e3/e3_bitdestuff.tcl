puts "Enter the stuffed message"
gets stdin message
set bits $message

set out ""
set count 0
set i 0
set len [string length $bits]

while {$i < $len} {
    set b [string index $bits $i]
    if {$b ne "0" && $b ne "1"} {
        puts "Error: Invalid character '$b'. Only '0' and '1' allowed."
        exit 1
    }

    append out $b
    if {$b eq "1"} {
        incr count
        if {$count == 5} {
            incr i
            if {$i < $len} {
                set nextBit [string index $bits $i]
                if {$nextBit ne "0"} {
                    append out $nextBit
                    if {$nextBit eq "1"0} {
                        set count 1
                    } else {
                        set count 0
                    }
                } else {
                    set count 0
                }
            }
        }
    } else {
    set count 0
    }
    incr i
}

puts "original stuffed message: $bits"
puts "\n the length of the stuffed message is $len \n"
puts "message after destuffing: $out"

set slen [string length $out]
puts "\n the length of the message after bit destuffing is $slen \n"