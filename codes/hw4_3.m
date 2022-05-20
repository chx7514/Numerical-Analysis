clear;
data = [1.00000,0.00000,-1.0000;
    0.80902,0.58779,-2.6807;
    0.30902,0.95106,5.6161;
    -0.30902,0.95106,5.6161;
    -0.80902,0.58779,-2.6807;
    -1.00000,0.00000,-1.0000;
    -0.80902,-0.58779,-2.6807;
    -0.30902,-0.95106,5.6161;
    0.30902,-0.95106,5.6161;
    0.80902,-0.58779,-2.6807];

x_in = data(:, 1) + 1i * data(:, 2);
y_in = data(:, 3);
% [x, y] = meshgrid(-1:.1:1,-1:.1:1);
% n = size(x, 1);

t = meshgrid(-1 : .1 : 1);
[x, y] = cylinder(t, 100);
x_out = reshape(x + 1i * y, [1, size(x,1) * size(x,2)]);
y_out = lagrange_poly_interpolation(x_in', y_in', x_out);
z = real(reshape(y_out, [size(x,1), size(x,2)]));
mesh(x, y, z);
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
txt = zlabel('$z$');
set(txt, 'Interpreter', 'latex');

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