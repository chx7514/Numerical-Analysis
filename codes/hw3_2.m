clear;
n = 20;
x = linspace(-1, 1, n);
y = f(x);

% use lagrange method
p = ones(1, n);
for i = 1 : n
    for j = 1 : n
        if i == j
            continue
        end
        p(i) = p(i) * (x(i) - x(j));
    end
end
x_show = linspace(-1, 1, 1000);
f_inter = zeros(1, 1000);
for i = 1 : 1000
    if ismember(x_show(i), x)
        f_inter(i) = y(x == x_show(i));
        continue;
    end
    temp = 1;
    for j = 1 : n
        temp = temp * (x_show(i) - x(j));
    end
    for j = 1 : n
        f_inter(i) = f_inter(i) + y(j) * temp / (x_show(i) - x(j)) / p(j);
    end
end
f_true = f(x_show);
plot(x_show, f_inter);
hold on;
plot(x_show, f_true);
scatter(x,y,'r.');
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
legend('interpolation', 'true','points');
txt = title('$graph\ of\ the\ function$');
set(txt, 'Interpreter', 'latex');
hold off
figure(2)
semilogy(x_show, abs(f_inter - f_true));
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$log|difference|$');
set(txt, 'Interpreter', 'latex');
txt = title(' the difference');
set(txt, 'Interpreter', 'latex');

function y = f(x)
    y = (1 + 25 * x.^2) .^ (-1);
%     y = sin(x);
end
    