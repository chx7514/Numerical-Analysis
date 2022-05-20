clear
data = [-4.00000 0.00001
-3.50000 0.00726
-3.00000 0.25811
-2.50000 1.87629
-2.00000 1.55654
-1.50000 0.17209
-1.00000 0.00899
-0.50000 0.05511
0.00000 0.24564
0.50000 0.60455
1.00000 0.89370
1.50000 1.03315
2.00000 0.51633
2.50000 0.18032
3.00000 0.04287
3.50000 0.00360
4.00000 0.00045];

x = data(:, 1);
y = data(:, 2);
c = [1.87629;0;-2.5;1.03315;0;1];
c(2)=rand(1)+1;
c(5)=rand(1);
t = 0;
n = size(x, 1);
Jacobi = ones(n, 6);
r = 10;
last_r = 0;
while norm(r-last_r, 2) > 1e-10
    last_r = r;
    y_hat = f(x, c);
    r = y - y_hat;
    Jacobi = Gradiant(x, c);
    dc = - lsqr(Jacobi, r);
    c = c + dc;
    t = t+1;
    if t == 1000
        break;
    end
end
x_show = linspace(-4, 4, 1000);
y_show = f(x_show', c);
plot(x_show, y_show)
hold on
scatter(x,y)
hold off

function y = g(x)
    y = exp(-x^2);
end

function y = f(xi, c)
    n = size(xi, 1);
    y = zeros(n, 1);
    for i = 1 : n
        x = xi(i);
        y(i) = c(1) * g(c(2) * (x - c(3))) + c(4) * g(c(5) * (x - c(6)));
    end
end

function Jacobi = Gradiant(xi, c)
    n = size(xi, 1);
    Jacobi = zeros(n, 6);
    for i = 1 : n
        x = xi(i);
        e1 = g(c(2)*(x-c(3)));
        e2 = g(c(5)*(x-c(6)));
        Jacobi(i, :) = -[e1, -2 * c(1) * c(2) * (x-c(3))^2 * e1, 2 * c(1) * c(2)^2 * (x-c(3)) * e1, e2, -2 * c(4) * c(5) * (x-c(6))^2 * e2, 2 * c(4) * c(5)^2 * (x-c(6)) * e2];
    end
end
