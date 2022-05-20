clear;
ii = 1 : 20;
kk = 2 .^ (ii);
errors = zeros(20, 1);
for i = 1 : 20
    k = kk(i);
    h = 1 / k;
    u0 = 1;
    u = u0;
    t = 0;
    for j = 1 : k
        k1 = f(t, u);
        k2 = f(t + h / 2, u + h * k1 / 2);
        k3 = f(t + h / 2, u + h * k2 / 2);
        k4 = f(t + h, u + h * k3);
        u = u + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        t = t + h;
    end
    errors(i) = abs(exp(1/2)-u);
end

h = 1 ./ kk;
plot(4*log(h(1:10)), log(errors(1:10)));
txt = xlabel('$4\log h$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$\log|errors|$');
set(txt, 'Interpreter', 'latex');
axis equal;

function y = f(t, u)
    y = t * u;
end