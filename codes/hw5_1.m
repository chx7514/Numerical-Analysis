clear;
n = 9;
x = linspace(0, 2 * pi, n);
y = sin(x); % 函数值

k0 = -1;
kn = 1;

h = x(2) - x(1);
beta = 1 / h;
alpha = 4 * beta;
A = diag(alpha * ones(n - 2,1)) + diag(beta * ones(n - 3,1), 1) + diag(beta * ones(n - 3,1), -1);

eta = zeros(n - 1, 1);
for i = 1 : n - 1
    eta(i) = 3 * (y(i + 1) - y(i)) / h^2;
end

b = eta(1:end-1) + eta(2:end);
b(1) = b(1) - beta * k0;
b(end) = b(end) - beta * kn;

k = A \ b;
k = [k0;k;kn];

x_show = linspace(0, 2*pi, 1000);
y_show = zeros(1, 1000);
t = 1;
for i = 1 : 1000
    if x_show(i) > x(t+1)
        t = t + 1;
    end
    y_show(i) = y(t) * phi((x(t+1)-x_show(i))/h) + y(t+1) * phi((x_show(i)-x(t))/h) - k(t)*h*psi((x(t+1)-x_show(i))/h)+k(t+1)*h*psi((x_show(i)-x(t))/h);
end
plot(x_show,y_show)
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
hold on
scatter(x,y)
legend('graph', 'interpolation nodes')
hold off

function y = phi(x)
    y = 3 * x^2 - 2 * x^3;
end

function y = psi(x)
    y = x^3 - x^2;
end