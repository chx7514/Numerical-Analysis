clear;
n = 3;
x = linspace(0, 2 * pi, n);
y = sin(x); % 函数值
d = cos(x); % 导数
A = zeros(4, n - 1); % 三次函数系数

for i = 1 : n - 1
    C = [x(i)^3, x(i)^2, x(i), 1;
        x(i+1)^3, x(i+1)^2, x(i+1), 1;
        3 * x(i)^2, 2 * x(i), 1, 0;
        3 * x(i+1)^2, 2 * x(i+1), 1, 0];
    b = [y(i), y(i+1), d(i), d(i+1)]';
    A(:, i) = C \ b;
end

x_show = linspace(0, pi, 1000);
y_show = zeros(1, 1000);
k = 1; %第几个分段函数
for i = 1 : 1000
    if x_show(i) > x(k+1)
        k = k + 1;
    end
    y_show(i) = A(1, k) * x_show(i)^3 + A(2, k) * x_show(i)^2 + A(3, k) * x_show(i) + A(4, k);
end
plot(x_show, y_show);
hold on;
plot(x_show, sin(x_show));
legend('piecewise cubic Hermite interpolation', 'sine function');
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');