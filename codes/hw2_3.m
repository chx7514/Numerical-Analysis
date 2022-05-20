clear
x = 1;
fx = f(x);
tol = 1e-10;
while abs(fx) > tol
    x = x - fx / derivative(x);
    fx = f(x);
end

function y = f(x)
    y = 2 * x / (1 + x^2) - atan(x);
end

function y = derivative(x)
    y = (1 - 3 * x^2) / (1 + x^2)^2;
end