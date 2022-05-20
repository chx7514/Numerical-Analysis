x = linspace(-10,10,1000);
y_a = zeros(1,1000);
y_b = zeros(1,1000);
for i = 1:1000
    y_a(i) = scheme_a(x(i));
    y_b(i) = scheme_b(x(i));
end
y_t = sin(x);
e_a = abs(y_a - y_t);
e_b = abs(y_b - y_t);
semilogy(x,e_a)
hold on
semilogy(x,e_b)
legend('scheme a','scheme b')

function [y,n] = scheme_a(x)
    n = 0;
    y = 0;
    tol = 1e-15;
    t = x;
    while abs(t) > tol
        n = n + 1;
        y = y + t;
        t = -t * x ^ 2 / (2 * n) / (2 * n + 1);
    end
end

function y = scheme_b(x)
    while x > pi
        x = x - 2 * pi;
    end
    while x <= - pi
        x = x + 2 * pi;
    end
    if x > pi / 2
        x = pi - x;
    end
    if x < - pi / 2
        x = - pi - x;
    end
    y = scheme_a(x);
end