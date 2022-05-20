clear;
stepi = 0 : 10;
ns = 2.^ stepi;
ns = ns';
times = [];
for i = 1 : 11
    t = 0;
    n = ns(i);
    for j = 1 : 10
        p1 = rand(n, 1);
        p2 = rand(n, 1);
        tic
        my_result = myconv(p1, p2);
        toc
        t = t + toc;
    end
    times = [times; t / 10];
end

plot(ns.*log(ns), times)
txt = xlabel('$n\log n$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$running\ time$');
set(txt, 'Interpreter', 'latex');


function [result] = myconv(p1, p2)
    length = max(size(p1, 1), size(p2, 1));
    k = ceil(log2(length));
    conv_length = 2 ^ (k + 1);
    p1_new = [p1; zeros(conv_length - size(p1, 1), 1)];
    p2_new = [p2; zeros(conv_length - size(p2, 1), 1)];
    P1 = myFFT(p1_new, conv_length);
    P2 = myFFT(p2_new, conv_length);
    result = myIFFT(P1 .* P2, conv_length) / conv_length;
    result = real(result);
    result = result(1 : size(p1, 1) + size(p2, 1) - 1);
end

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