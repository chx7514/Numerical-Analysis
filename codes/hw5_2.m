clear;
data = [1 36.37
    3 36.23
    5 36.21
    7 36.26
    8 36.38
    9 36.49
    10 36.60
    11 36.63
    12 36.66
    13 36.68
    14 36.69
    15 36.73
    16 36.74
    17 36.78
    18 36.82
    19 36.84
    20 36.87
    21 36.86
    22 36.77
    23 36.59];
x = data(:, 1);
x = [0; x; 24];
y = data(:, 2);
y_mean = (y(1) + y(end)) / 2;
y = [y_mean; y; y_mean];
n = size(x, 1) - 1;
h = zeros(1, n);
for i = 1 : n
    h(i) = x(i+1)-x(i);
end
beta = 1 ./ h;
alpha = zeros(1, n);
alpha(1) = 2 * (beta(1) + beta(end));
for i = 2 : n
    alpha(i) = 2 * (beta(i-1)+beta(i));
end

A = diag(alpha) + diag(beta(1:end-1), 1) + diag(beta(1:end-1), -1);
A(1, end) = beta(end);
A(end, 1) = beta(end);
eta = zeros(n, 1);
for i = 1 : n
    eta(i) = 3 * (y(i + 1) - y(i)) / h(i)^2;
end
b = eta + [eta(end);eta(1:end-1)];

k = A \ b;
k = [k;k(1)];

x_show = linspace(0, 48, 1000);
y_show = zeros(1, 1000);
t = 1;
ht = h(1);
flag = 0;
for i = 1 : 1000
    xi = x_show(i);
    if flag
        xi = xi - 24;
    end
    if xi > x(t+1) && t == n
       xi = xi - 24;
       t = 1;
       flag = 1;
    else
        if xi > x(t + 1)
            t = t + 1;
        end
    end
    ht = h(t); 
    y_show(i) = y(t) * phi((x(t+1)-xi)/ht) + y(t+1) * phi((xi-x(t))/ht) - k(t)*ht*psi((x(t+1)-xi)/ht)+k(t+1)*ht*psi((xi-x(t))/ht);
end
plot(x_show,y_show)
txt = xlabel('$Time$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$Temperature$');
set(txt, 'Interpreter', 'latex');
hold on
scatter(x,y);
legend('graph','interpolation nodes');
hold off

function y = phi(x)
y = 3 * x^2 - 2 * x^3;
end

function y = psi(x)
y = x^3 - x^2;
end