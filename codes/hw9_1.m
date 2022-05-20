clear;
stepi=0:10;
steps = 0.5.^stepi;
error_0 = zeros(11, 1);
error_1 = zeros(11, 1);
error_2 = zeros(11, 1);

for j = 1: 11
    step = steps(j);
    x = 1:step:4;
    n = size(x, 2);
    y = exp(x)+log(x); % 函数值

    k0 = exp(1) + 1;
    kn = exp(4) + 1/4;

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

    x_show = linspace(1, 4, 1000);
    y_0 = zeros(1, 1000);
    y_1 = zeros(1, 1000);
    y_2 = zeros(1, 1000);

    t = 1;
    for i = 1 : 1000
        if x_show(i) > x(t+1)
            t = t + 1;
        end
        y_0(i) = y(t) * phi((x(t+1)-x_show(i))/h) + y(t+1) * phi((x_show(i)-x(t))/h) - k(t)*h*psi((x(t+1)-x_show(i))/h)+k(t+1)*h*psi((x_show(i)-x(t))/h);
        y_1(i) = -y(t) * phi_1((x(t+1)-x_show(i))/h)/h + y(t+1) * phi_1((x_show(i)-x(t))/h)/h + k(t)*psi_1((x(t+1)-x_show(i))/h) + k(t+1)*psi_1((x_show(i)-x(t))/h);
        y_2(i) = y(t) * phi_2((x(t+1)-x_show(i))/h)/h^2 + y(t+1) * phi_2((x_show(i)-x(t))/h)/h^2 - k(t)*psi_2((x(t+1)-x_show(i))/h)/h + k(t+1)*psi_2((x_show(i)-x(t))/h)/h;
    end
    error_0(j) = norm(abs(exp(x_show)+log(x_show) - y_0), 'inf');
    error_1(j) = norm(abs(exp(x_show)+1./x_show - y_1), 'inf');
    error_2(j) = norm(abs(exp(x_show)-1./(x_show).^2 - y_2), 'inf');
end

loglog(steps, error_0);
hold on;
loglog(steps, error_1);
loglog(steps, error_2);
txt = legend('$y$','$y''$','$y''''$');
set(txt, 'Interpreter', 'latex');
txt = xlabel('$step\ size$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$\|\hat y - y\|_\infty$');
set(txt, 'Interpreter', 'latex');

% figure();
% plot(x_show,y_1)
% hold on;
% plot(x_show,exp(x_show)+1./x_show) 
% txt = xlabel('$x$');
% set(txt, 'Interpreter', 'latex');
% txt = ylabel('$y''$');
% set(txt, 'Interpreter', 'latex');
% legend('cubic spline', 'real')
% hold off
% 
% figure();
% plot(x_show,exp(x_show)+1./x_show-y_1) 
% txt = xlabel('$x$');
% set(txt, 'Interpreter', 'latex');
% txt = ylabel('$error\ of\ y''$');
% set(txt, 'Interpreter', 'latex');
% 
% figure();
% plot(x_show,y_2);
% hold on;
% plot(x_show,exp(x_show)-1./(x_show).^2); 
% txt = xlabel('$x$');
% set(txt, 'Interpreter', 'latex');
% txt = ylabel('$y''''$');
% set(txt, 'Interpreter', 'latex');
% legend('cubic spline', 'real')
% hold off
% 
% figure();
% plot(x_show,exp(x_show)-1./(x_show).^2-y_2) 
% txt = xlabel('$x$');
% set(txt, 'Interpreter', 'latex');
% txt = ylabel('$error\ of\ y''''$');
% set(txt, 'Interpreter', 'latex');

function y = phi(x)
    y = 3 * x^2 - 2 * x^3;
end

function y = phi_1(x)
    y = 6 * x - 6 * x^2;
end

function y = phi_2(x)
    y = 6 - 12 * x;
end

function y = psi(x)
    y = x^3 - x^2;
end

function y = psi_1(x)
    y = 3 * x^2 - 2 * x;
end

function y = psi_2(x)
    y = 6 * x - 2;
end