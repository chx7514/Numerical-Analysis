clear
x = linspace(-0.3,10,100);
y = zeros(1, 100);
tol1 = 1e-15;
tol2 = 1e-15;
for i = 1:100
    x_i = x(i);
    a = -1;
    b = 2;
    while 1
        y_i = (a + b) / 2;
        if b - a <= tol1
            break;
        end
        f_y = lambert(y_i) - x_i;
        if abs(f_y) < tol2
            break;
        end
        if f_y < 0
            a = y_i;
        else
            b = y_i;
        end
    y(i) = y_i;
    end
end
y_real = lambertw(x);
plot(x,y)
xlabel('x')
ylabel('y')
title('graph of Lambert W-function')
hold on
plot(x,y_real)
legend('my function', 'matlab function')
figure(2)
semilogy(x, abs(y - y_real))
xlabel('x')
ylabel('log|error|')
title('graph of errors')
hold off

function y = lambert(x)
    y = x * exp(x);
end