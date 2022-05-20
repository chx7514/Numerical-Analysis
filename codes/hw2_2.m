clear
tol1 = 1e-12;
tol2 = 1e-13;
% bisection
a = 0;
b = 1;
x1 = [];
while 1
    x = (a + b) / 2;
    x1 = [x1, x];
    if b - a <= tol1
        break
    end
    fx = f(x);
    if abs(fx) <= tol2
        break
    end
    if fx < 0
        a = x;
    else
        b = x;
    end
end

% regula falsi
x2 = [];
a = 0;
b = 1;
fa = f(a);
fb = f(b);
while 1
    x = (a * fb - b * fa) / (fb - fa);
    x2 = [x2, x];
    if b - a <= tol1
        break
    end
    fx = f(x);
    if abs(fx) <= tol2
        break
    end
    if fx < 0
        a = x;
        fa = fx;
    else
        b = x;
        fb = fx;
    end
end

% visualize the convergence
plot(x1)
hold on
plot(x2)
legend('bisection', 'regula falsi')
xlabel('iteration number')
ylabel('x_k')
title('Convergence History of Two Methods')
hold off

% f
function y = f(x)
    y = x^64 -0.1;
end