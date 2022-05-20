clear;
n = 20;
equispaced = linspace(-1, 1, n);
Chebyshev = zeros(1, n);
for i = 1 : n
    Chebyshev(i) = cos((2 * i - 1) * pi / (2 * n));
end
x_show = linspace(-1, 1, 1000);
result_equispaced = lagrange_poly_interpolation(equispaced, abs(equispaced), x_show);
result_Chebyshev = lagrange_poly_interpolation(Chebyshev, abs(Chebyshev), x_show);
plot(x_show, result_equispaced);
hold on;
plot(x_show, result_Chebyshev);
plot(x_show, abs(x_show));
scatter(equispaced, abs(equispaced), 100, '.');
scatter(Chebyshev, abs(Chebyshev), 100, '.');
legend('result of equispaced nodes', 'result of Chebyshev nodes', 'truth', 'equispaced nodes', 'Chebyshev nodes');
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
hold off

function y_out = lagrange_poly_interpolation(x_in, y_in, x_out)
    n = size(x_in, 2);
    m = size(x_out, 2);
    p = ones(1, n);
    y_out = zeros(1, m);
    
    for i = 1 : n
        for j = 1 : n
            if i == j
                continue
            end
            p(i) = p(i) * (x_in(i) - x_in(j));
        end
    end
        
    for i = 1 : m
        if ismember(x_out(i), x_in)
            y_out(i) = y_in(x_in == x_out(i));
            continue;
        end
        temp = 1;
        for j = 1 : n
            temp = temp * (x_out(i) - x_in(j));
        end
        for j = 1 : n
            y_out(i) = y_out(i) + y_in(j) * temp / (x_out(i) - x_in(j)) / p(j);
        end
    end
end