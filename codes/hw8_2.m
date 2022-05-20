clear;

h = 1;
truth = 4 * exp(1);
t = 1;
T = {};
T{1} = (f(t + h) - f(t - h)) / 2 / h;
n = 1;
result = T{1};
while n < 100
    n = n + 1;
    h = h / 2;
    T{n} = zeros(1, n);
    T{n}(1) = (f(t + h) - f(t - h)) / 2 / h;
    for k = 2 : n
        T{n}(k) = (4 ^ (k - 1) * T{n}(k - 1) - T{n - 1}(k - 1)) / (4 ^ (k - 1) - 1);
    end
    result = [result;T{n}(n)];
%     if abs(T{n}(n) - T{n - 1}(n - 1)) < 1e-10
%         break;
%     end
end
semilogy(abs(result-truth));
txt = xlabel('$n$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$log|T_{n,0}-I|$');
set(txt, 'Interpreter', 'latex');
figure();
intermediate = [];
for i = 1 : n
    intermediate = [intermediate, T{i}];
end
semilogy(abs(intermediate-truth));
txt = ylabel('$log|T_{n,k}-I|$');
set(txt, 'Interpreter', 'latex');
title('intermediate value');

function y = f(x)
    y = x^3 * exp(x);
end