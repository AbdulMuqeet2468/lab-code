clc; clear all; close all;

m = input('Enter message:','s');
g = input('Enter pattern:','s');
lm = length(m);
lg = length(g);

t = strcat(m, dec2bin(0,(g-1)));
lt = length(t);
xm = t(1:lg);
rem1 = '';

for i = lg:1:lt
    if (xm(1) == g(1))
        xm1 = bin2dec(xm);
        g1 = bin2dec(g);
        rem1 = dec2bin(bitxor(xm1,g1),lg);
    end

    if i == lt
        rem1 = rem1(2:end);
        break;
    end

    rem1 = strcat(rem1(2:end), t(i+1));
    xm = rem1;
end

tm = strcat(m,rem1);
disp('The final remainder is:');
disp(rem1);
disp(['frame to be transmitted is' , tm]);
