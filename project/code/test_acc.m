clear;
n = 1000;
error = [];
for i = 2 : n
    e = 0;
    for j = 1 : 10
        x = rand(1, i);
        X = myfft(x);
        X_true = fft(x);
        e = e + norm(X-X_true);
    end
    error = [error, e/10];
end

plot(2:1000,error)
txt = xlabel('$n$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$\|myfft(x)-fft(x)\|$');
set(txt, 'Interpreter', 'latex');

