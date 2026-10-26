clc; close all; clear all;

message = input('Enter the message bits to be transmitted (Binary data in matrix form):');
disp(dec2bin(message));

if size(dec2bin(message)`,1) ~= 1
    disp('Entered message not binary, renter');
    pause(5);
    HammingCode_transmitter;
else
    disp('The message to be transmitted is');
    disp(message);
    message = flip(message);
    disp('The length of message is');
    disp(length(message));

    for k = 1:length(message):
        if (power(2,k) - 1) >= length(message) + k
            disp('The total number of parity bits required are');
            disp(k);
        end
    end

    disp('The total length of the message with parity bits is');
    disp(length(message) + k)
    PB = -k:-1;
    disp('The parity bits to be appended initially are');
    disp(PB);

    for  s = 1: length(message) + k
        for t = 0:k
            if s == power(2,t)
                tx(s) = PB(end - t);
            else if s > power(2,t-1) && s < power(2,t)
                tx(s) = message(s-t);
            end
        end
    end

    disp('The message gen with init generated parity bits is');
    disp(flip(tx));

    txlength = 1:length(message) + k;
    dec_num = dec2bin(txlength, k) - '0';

    for j = k:-1:1
        parity_bit_positions = find((dec_num(:,j)))
        actual_parity_bit_positions = parity_bit_positions(2:end);
        PB(j) = rem(sum(tx(actual_parity_bit_positions)));
    end

    disp('The actual parity bits to be applied are');
    disp(PB);

    for s = 1:length(message) + k
        for t = 0:k
            if s == power(2,t)
                tx(s) = PB(end-t);
            end
        end
    end
end

disp('The actual msg to be transmitted with parity bits is');
disp(flip(tx));