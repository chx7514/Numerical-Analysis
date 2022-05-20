clear
x = 3;
record = x;
fx = f(x);
tol = 1e-15;
while abs(fx) > tol
    x = x - fx / derivative(x);
    record = [record, x];
    fx = f(x);
end
plot(record)
xlabel('iteration number')
ylabel('x_k')
title('Convergence history')

function y = f(x)
    y = 1 + cos(x);
end

function y = derivative(x)
    y = -sin(x);
end