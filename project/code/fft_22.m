% another radix-2
function [X] = fft_22(x)
    n = size(x, 2);
    if n == 2
        X = [x(1) + x(2), x(1) - x(2)];
    else
        X = zeros(size(x));
        temp1 = x(1:n/2) + x(n/2+1:n);
        temp2 = (x(1:n/2) - x(n/2+1:n)) .* exp(-1i*(2*pi*linspace(0, n/2-1, n/2)/n));

        X(1:2:n) = fft_22(temp1);
        X(2:2:n) = fft_22(temp2);
    end
end
