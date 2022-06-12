nn = 4 .^ (1:10);
times = [];
for i = 1:10
    t = 0;
    n = nn(i);
    for j = 1 : 10
        x = rand(1, n)+1i*rand(1, n);
        tic;
        X = fft_22(x);
        toc;
        t = t + toc;
    end
    times = [times; t / 10];
end

plot(times)

nn = 4 .^ (1:10);
times = [];
for i = 1:10
    t = 0;
    n = nn(i);
    for j = 1 : 10
        x = rand(1, n);
        tic;
        X = split_radix(x);
        toc;
        t = t + toc;
    end
    times = [times; t / 10];
end
hold on;
plot(times)

txt = xlabel('$n$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('time');
set(txt, 'Interpreter', 'latex');
legend('radix 2','split radix');