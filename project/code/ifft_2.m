% radix == 2
function [X] = ifft_2(x)
    n = size(x, 2);
    X = myfun(x);
    X = X / n;
end

% radix == 2
function [X] = myfun(x)
    n = size(x, 2);
    if n == 2
        X = [x(1) + x(2), x(1) - x(2)];
    else
        w = exp(1i * (2 * pi * linspace(0, n / 2 - 1, n / 2) / n));
        x1 = myfun(x(1 : 2 : n-1)); 
        x2 = w .* myfun(x(2: 2 : n));
        X = [x1 + x2, x1 - x2];
    end
end