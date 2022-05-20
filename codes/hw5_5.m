clear;
data= [1 1 + 1
2 3 + 5
3 2 + 14
4 3 + 16
5 0 + 28
6 3 + 45
7 4 + 51
8 3 + 62
9 4 + 76
10 11 + 64
11 5 + 78
12 1 + 64
13 41 + 128
14 9 + 130
15 5 + 197
16 8 + 150
17 57 + 203
18 8 + 366
19 17 + 492
20 24 + 734];

t = data(:, 1);
N = data(:, 2);

% linearized
c = lsqr([ones(20,1), t],log(N));

alpha1 = exp(c(1));
beta1 = exp(c(2));

r = N - alpha1 * (beta1.^t);

norm(r)

x_show = linspace(0, 20, 1000);
y_show = alpha1 * beta1 .^ x_show;
plot(x_show, y_show);
hold on;
scatter(t, N)

% nonlinear
c = [alpha1; beta1];
r = zeros(20, 1);
last_r = ones(20, 1);
Jacobi = zeros(20, 2);
while norm(r - last_r) > 1e-10
    last_r = r;
    r = N - c(1) * (c(2).^t);
    Jacobi(:, 1) = c(2) .^ t;
    Jacobi(:, 2) = c(1) * t .* (c(2) .^ (t-1));
    dc = lsqr(Jacobi, r);
    c = c + dc;
end
norm(r)

alpha2 = c(1);
beta2 = c(2);
y_show = alpha2 * beta2 .^ x_show;
plot(x_show, y_show);
txt = xlabel('$t$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$N$');
set(txt, 'Interpreter', 'latex');
legend('linear', 'data','nonlinear');
hold off;
