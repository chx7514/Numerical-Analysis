clear;
x = linspace(-8, 12, 1000);
y1 = zeros(1, 1000);
c = zeros(1, 10);
for i = 0:9
    c(i + 1) = cfun(9, i);
end

for i = 1:1000
    for j = 0:9
        y1(i) = y1(i) + c(j + 1) * x(i)^j * (-2)^(9 - j);
    end
end
y2 = (x - 2).^9;
plot(x, y1);
hold on;
plot(x, y2);
legend('expanded form','not expanded');
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
title('Graph of the Function');
hold off;
figure(2);
semilogy(x, abs(y2 - y1));
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$log |\Delta y|$');
set(txt, 'Interpreter', 'latex');
title('Difference between Two Scheme')

function y = cfun(n, m)
    y = factorial(n) / factorial(m) / factorial (n - m);
end