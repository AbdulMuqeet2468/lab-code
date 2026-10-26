clc; clear all; close all;

tm = input('Enter transmitted frame:','s');
g = input('Enter pattern:','s');
ltm = length(tm);
lg = length(g);

txm = tm(1:lg);
rem1 = '';

for i = lg:1:ltm
    if (txm(1) == g(1))
        txm1 = bin2dec(txm);
        g1 = bin2dec(g);
        rem1 = dec2bin(bitxor(txm1,g1),g);
    end

    if i == ltm
        rem1 = rem1(2:end);
        break;
    end

    rem1 = strcat(rem1(2:end), tm(i+1));
    txm = rem1;
end

drem = bin2dec(rem1);
if drem == 0
    rem1 
    disp("No error, ready to recieve another frame");
else
    rem1
    disp("Error, please retransmit");
    dy = input('If you want to retransmit press y, else n','s');

    if dy == 'y'
        DCRC()
    end
end
