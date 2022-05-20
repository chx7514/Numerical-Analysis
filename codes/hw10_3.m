clear;
x = linspace(-5, 5, 10000)';
y = f(x);
% scatter(x, y, 2, '.');

sigma = 1;
gauss = 1 / sqrt(2 * pi) / sigma * exp(-x .^ 2 / 2 / sigma^2);
gauss = gauss / norm(gauss, 1);
result = conv(y, gauss, 'same');
figure();
scatter(x, result, 2, '.');


function [X] = myFFT(x,n)
    if n == 2
        X = [x(1) + x(2); x(1) - x(2)];
    else
        w = (exp(-1i*(2*pi*linspace(0,n/2-1,n/2)/n)))';
        x1 = myFFT(x(1:2:n-1),n/2);
        x2 = w.*myFFT(x(2:2:n),n/2);
        X = [x1 + x2; x1 - x2];
    end
end

function [X] = myIFFT(x,n)
    if n == 2
        X = [x(1) + x(2); x(1) - x(2)];
    else
        w = (exp(1i*(2*pi*linspace(0,n/2-1,n/2)/n)))';
        x1 = myIFFT(x(1:2:n-1),n/2);
        x2 = w.*myIFFT(x(2:2:n),n/2);
        X = [x1 + x2; x1 - x2];
    end
end

function y = f(x)
    y = floor(x);
end