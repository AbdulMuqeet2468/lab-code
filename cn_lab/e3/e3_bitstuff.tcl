puts "Enter the message:"
gets stdin message
set bits $message

set out ""
set count 0
set len [string length $bits]

for {set i 0} {$i < $len} {incr i} {
    set b [string index $bits $i]
    if {$b ne "0" && $b ne "1"} {
        puts "Error: invalid character '$b'. Only '0' and '1' are allowed."
        exit 1
    }

    append out $b 
    if {$b eq "1"} {
        incr count
        if {$count == 5} {
            append out "0"
            set count 0
        }
    } else {
        set count 0
    }
}

puts "Original Message: $bits"
puts "\n The length pf the original message is $len \n"
puts "message after bitstuffing: $out"

set slen [string length $out]
puts "\n The length of the original message is $slen \n"