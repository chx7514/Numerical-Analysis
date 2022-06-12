% split radix: 2 & 4
function [X] = split_radix(x)
    n = size(x, 2);
    if n == 2
        X = fft_2(x);        
    else
        if n == 4
            X = fft_2(x);
        else
            X = zeros(size(x));
            temp = x(1:n/2) + x(n/2+1:n);
            X(1:2:n) = split_radix(temp);

            w1 = exp(-1i*(2*pi*linspace(0,n/4-1,n/4)/n));
            temp1 = (x(1:n/4)-x(n/2+1:3*n/4)) .* w1;
            temp2 = 1i*(x(n/4+1:n/2)-x(3*n/4+1:n)) .* w1;

            X(2:4:n) = split_radix(temp1 - temp2);
            
            temp1 = temp1 .* w1 .*w1;
            temp2 = temp2 .* w1 .*w1;
            X(4:4:n) = split_radix(temp1 + temp2);
        end
    end
end