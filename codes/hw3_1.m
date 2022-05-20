clear;
global kh k1 k2 kw p
kh = 10^(-1.46);
k1 = 10^(-6.3);
k2 = 10^(-10.3);
kw = 10^(-14);
p = 375;
tol = 1e-12;
x = -7 * ones(4, 1);
fx = f(x);
error = norm(fx);

% Newton's Method
while norm(fx) > tol
    x = x - Jacobi(x) \ fx;
    fx = f(x);
    error = [error, norm(fx)];
end

% good broyden
% inv_J = eye(4);
% while norm(fx) > tol
%     dx = - inv_J * fx;
%     x = x + dx;
%     df = f(x) - fx;
%     fx = fx + df;
%     inv_J = inv_J + (dx - inv_J * df) * dx' * inv_J / (dx' * inv_J * df);
%     error = [error, norm(fx)];
% end
% 
% % bad broyden
% while norm(fx) > tol
%     dx = -inv_J * fx;
%     x = x + dx;
%     df = f(x) - fx;
%     fx = fx + df;
%     inv_J = inv_J + (dx - inv_J * df) * df' / (df' * df);
%     error = [error, norm(fx)];
% end
semilogy(error)

function y = f(x)
    global kh k1 k2 kw p
    y = zeros(4, 1);
    y(1) = x(1) * x(2) - kw;
    y(2) = x(1) * x(3) - k1 * kh * p / 10^6;
    y(3) = x(1) * x(4) / x(3) - k2;
    y(4) = x(1) - x(2) - x(3) - 2 * x(4);
end

function J = Jacobi(x)
    J = [x(2), x(1), 0, 0;
        x(3), 0, x(1), 0;
        x(4) / x(3), 0, -x(1) * x(4) / x(3)^2, x(1) / x(3);
        1, -1, -1, -2];
end