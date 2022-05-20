clear;
tol = 1e-10;
n = 2;
x=rand(n+2,1);
x = sort(x);
init = sort(x);
intermediate = [];
solution = [];
r = [];
while 1
    A = zeros(n + 2);
    for i = 0 : n
        A(:, i + 1) = x.^i;
    end
    A(:, n + 2) = (-1) .^ (0 : (n+1));
    b = f(x);
    sol = A \ b;
    ext = extreme(sol(3), sol(2));
    intermediate = [intermediate, sort(ext)];
    ext = ext(ext>=0 & ext <=1);
    [val, ind] = max(abs(f(ext)-p(ext, sol(1:end-1))));
    ext = ext(ind);
    if abs(f(0) - p(0, sol(1:end-1))) > val
        ext = 0;
        val = abs(f(0) - p(0, sol(1:end-1)));
    end
    if abs(f(1) - p(1, sol(1:end-1))) > val
        ext = 1;
    end
    x = new_x(x,ext,sol);
    init = [init,sort(x)];
    E = abs(sol(end));
    solution = [solution,E];
    r = [r;abs(max(abs(f(ext)-p(ext, sol(1:end-1)))-E))];
    if abs(max(abs(f(ext)-p(ext, sol(1:end-1)))-E)) < tol
        break;
    end
end
x_show = linspace(0, 1, 100);
y_f = f(x_show);
y_p = p(x_show, sol(1:end-1));
plot(x_show,y_f);
hold on;
plot(x_show,y_p);
legend('ln(1+x)','p(x)');
title('function graph');
hold off;
figure(2);
plot(init(1,:));
hold on;
for i = 2: 4
    plot(init(i,:));
end
title('initial guess');
hold off;
figure(3);
plot(intermediate(1,:));
hold on;
plot(intermediate(2,:));
title('intermediate solutions')
hold off;
figure(4);
plot(solution);
title('E');
figure(5);
plot(r);
title('approximation error');


function y = f(x)
    y = log(1 + x);
end

function y = p(x, coef)
    c = coef(1);
    b = coef(2);
    a = coef(3);
    y = a * x.^2 + b * x + c;
end

function x = extreme(a, b)
    delta = (2 * a + b)^2 - 8 * a * (b - 1);
    x = [sqrt(delta); -sqrt(delta)];
    x = (x - (2 * a + b)) / (4 * a);
end

function x = new_x(x,ext,sol)
    if ext < x(1)
        if (f(ext)-p(ext,sol(1:end-1)))*(f(x(1))-p(x(1),sol(1:end-1)))>0
            x(1)=ext;
        else
            x = [ext;x(1:end-1)];
        end
    elseif ext > x(end)
        if (f(ext)-p(ext,sol(1:end-1)))*(f(x(end))-p(x(end),sol(1:end-1)))>0
            x(end)=ext;
        else
            x = [x(2:end);ext];
        end
    else
        [~,ind] = min(abs(x-ext));
        if x(ind) > ext
            ind = ind - 1;
        end
        if (f(ext)-p(ext,sol(1:end-1)))*(f(x(ind))-p(x(ind),sol(1:end-1)))>0
            x(ind)=ext;
        else
            x(ind+1)=ext;
        end
    end
end