clear;
m = 1;
k = 1;
A = [0, 1; -k / m, 0];
u0 = [0;1];
h = 0.1;
t = 0;
T = 100;
[idx, result_Euler] = Euler(A, u0, t, T, h);
[~, result_backward_Euler] = backward_Euler(A, u0, t, T, h);
[~, result_ex_trapezoidal] = ex_trapezoidal(A, u0, t, T, h);
[~, result_im_trapezoidal] = im_trapezoidal(A, u0, t, T, h);
[~, result_RH4] = RH4(A, u0, t, T, h);

gt = sin(idx);
error1 = norm(result_Euler(1,:) - gt, 'inf')
error2 = norm(result_backward_Euler(1,:) - gt, 'inf')
error3 = norm(result_ex_trapezoidal(1,:) - gt, 'inf')
error4 = norm(result_im_trapezoidal(1,:) - gt, 'inf')
error5 = norm(result_RH4(1,:) - gt, 'inf')

plot(idx, result_Euler(1, :));
title('Euler');
figure();
plot(idx, result_backward_Euler(1, :));
title('backward Euler')
figure();
plot(idx, result_ex_trapezoidal(1, :));
hold on;
plot(idx, result_im_trapezoidal(1, :));
plot(idx, result_RH4(1, :));
legend('explicit trapezoidal', 'implicit trapezoidal', 'RH4');
hold off;

figure(); 
subplot(2,3,1); plot(result_Euler(1,:),result_Euler(2,:)); title('Euler');
subplot(2,3,2); plot(result_backward_Euler(1,:),result_backward_Euler(2,:)); title('backward Euler');
subplot(2,3,3); plot(result_ex_trapezoidal(1,:),result_ex_trapezoidal(2,:)); title('explicit trapezoidal');
subplot(2,3,4); plot(result_im_trapezoidal(1,:),result_im_trapezoidal(2,:)); title('implicit trapezoidal');
subplot(2,3,5); plot(result_RH4(1,:),result_RH4(2,:)); title('RH4');



function [idx, result] = Euler(A, u0, t, T, h)
    u = u0;
    result = u;
    idx = t;
    while t <= T
        k1 = A * u;
        u = u + h * k1;
        t = t + h;
        result = [result, u];
        idx = [idx, t];
    end
end

function [idx, result] = backward_Euler(A, u0, t, T, h)
    u = u0;
    result = u;
    idx = t;
    I = eye(2);
    B = inv(I - h * A);
    while t <= T
        u = B * u;
        t = t + h;
        result = [result, u];
        idx = [idx, t];
    end
end

function [idx, result] = ex_trapezoidal(A, u0, t, T, h)
    u = u0;
    result = u;
    idx = t;
    while t <= T
        k1 = A * u;
        k2 = A * (u + h * k1);
        u = u + h * (k1 + k2) / 2;
        t = t + h;
        result = [result, u];
        idx = [idx, t];
    end
end

function [idx, result] = im_trapezoidal(A, u0, t, T, h)
    u = u0;
    result = u;
    idx = t;
    I = eye(2);
    B = inv(I - h * A / 2);
    C = I + h * A / 2;
    while t <= T
        u = B * C * u;
        t = t + h;
        result = [result, u];
        idx = [idx, t];
    end
end

function [idx, result] = RH4(A, u0, t, T, h)
    u = u0;
    result = u;
    idx = t;
    while t <= T
        k1 = A * u;
        k2 = A * (u + h * k1 / 2);
        k3 = A * (u + h * k2 / 2);
        k4 = A * (u + h * k3);
        u = u + h * (k1 + 2 * k2 + 2 * k3 + k4) / 6;
        t = t + h;
        result = [result, u];
        idx = [idx, t];
    end
end