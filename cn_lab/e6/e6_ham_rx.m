clc; close all; clear all;

rmessage = input('Enter recieved message (Binary data in matrix form):');
disp(dec2bin(rmessage)');

if size(dec2bin(rmessage)',1) ~= 1
    disp('The recieved message not binary, please wait for 5 seconds to renter');
    pause(5);
    HammingCode_Reciever;
else
    disp('The message recieved is');
    disp(rmessage);
    rmessage = flip(rmessage);
    disp('The length of recieved message is');
    disp(length(rmessage));

    for k = 1:length(rmessage)
        if (power(2,k)) >= length(rmessage) + 1
            disp('The total number of parity bits in recieved msg are');
            disp(k);
            break;
        end
    end

    disp('The total length without parity bits is');
    disp(length(rmessage) - k)
    rxlength = 1:length(rmessage);
    dec_num = dec2bin(rxlength,k) - '0';

    for j = k:-1:1
        parity_bit_positions = find((dec_num(:,j))');
        if rem(sum(rmessage(parity_bit_positions)),2) == 0
            flag(j) = 0;
        else 
            flag(j) = 1;
        end
    end

    if flag == zeros(1,k)
        disp('There is no error');
    else
        disp('the recieved msg has ERROR');
        disp(flag);
        decvalue = 0;

        for i = 1:length(flag)
            decvalue = decvalue + power(2 , (length(flag) - i)) * flag(i);
        end

        disp('The error is present in the bit');
        disp(decvalue);

        if rmessage(decvalue) == 1
            rmessage(decvalue) = 0;
        else 
            rmessage(decvalue) = 1;
        end
    end
end

disp('The correct message recieved is');
disp(flip(rmessage));