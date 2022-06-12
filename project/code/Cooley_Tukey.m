% arbiturary Composite length
function [X] = Cooley_Tukey(x)
    N = size(x, 2);
    if N == 2
        X = fft_2(x);
        return;
    end
    if N == 3
        X = fft_3(x);
        return
    end
    if N == 5
        X = fft_5(x);
        return;
    end
    factors = factor(N);
    N1 = factors(1);
    N2 = N / N1;
    x = reshape(x, N1, N2);
    for i = 1 : N1
        x(i, :) = myfft(x(i, :));
    end
    [n1, n2] = meshgrid((0 : N2 - 1), (0 : N1 - 1));
    n = n1 .* n2;
    x = x .* exp(-1i * (2 * pi * n) / N);
    for i = 1 : N2
        x(:, i) = myfft(x(:, i).').';
    end
    X = reshape(x.', 1, N);
end

