clc; clear all; close all;

m = input('Enter message:','s');
g = input('Enter pattern:','s');

lm = length(m);
lg = length(g);

t = strcat(m, repmat('0',1,lg-1));
lt = length(t);

xm = t(1:lg);
rem1 = '';

for i = lg:lt
    if xm(1) == '1'
        xm1 = bin2dec(xm);
        g1 = bin2dec(g);
        rem1 = dec2bin(bitxor(xm1,g1),lg);
    else
        rem1 = xm;
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
disp(['Frame to be transmitted is ',tm]);