clear;
u = zeros(201, 3);
u(1, :) = [1, 0, 100];
mu = 10;
K = 10;
Ks = 10;
kd = 0.1;
ke = 0.1;
kh = 0.1;
f=@(t, u) [mu * (1 - u(1) / K) * (u(3) / (u(3) + Ks)) * u(1)-kd * u(1) - ke * u(1);... 
    kd * u(1) - kh * u(2); ...
    ke * u(1) + kh * u(2) - mu * (1 - u(1) / K) * (u(3) / (u(3) + Ks)) * u(1)];
t = 0;
      
for i = 2 : 201
    u(i, :) = RH4(f, u(i-1, :), t, t + 1, 100);
    t = t + 1;
end
      
idx = 0 : 200;
plot(idx, u);
legend('X', 'C', 'S');
xlabel('t');
ylabel('concentration');
hold off;

function u = RH4(f, u0, t, T, k)
    h = (T - t) / k;
    u = u0;
    for j = 1 : k
        k1 = f(t, u);
        k2 = f(t + h / 2, u + h * k1 / 2);
        k3 = f(t + h / 2, u + h * k2 / 2);
        k4 = f(t + h, u + h * k3);
        u = u + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        t = t + h;
    end
end