% prime length
function [X] = rader(x)
    N = size(x, 2);
    g = findPrimitiveRoot(N);
    a = zeros(1, N - 1);
    b = zeros(1, N - 1);
    idx = zeros(1, N - 1);
    a_t = 1;
    b_t = 1;
    inv_g = expmodinv(g, 1, N);
    for q = 0 : N - 2
        idx(q + 1) = b_t + 1;
        a(q + 1) = x(a_t + 1);
        b(q + 1) = exp(-1i * 2 * pi * b_t / N);
        a_t = mod(a_t * g, N);
        b_t = mod(b_t * inv_g, N);
    end
    M = next(2 * N - 3);
    a = [a(1), zeros(1, M - N + 1), a(2 : end)];
    while length(b) < M
        b = [b, b];
    end
    b = b(1:M);
    conv_result = ifft_2(fft_2(a) .* fft_2(b));
    conv_result = conv_result(1 : N - 1);
    X = zeros(1, N);
    X(1) = sum(x);
    X(idx) = conv_result(1 : N - 1) + x(1);
end

function [y] = next(n)
    y = 2;
    while y < n
        y = y * 2;
    end
end