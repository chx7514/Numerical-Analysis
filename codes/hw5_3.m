clear;
data = [-1.0000 -1.0000 1.6389
-1.0000 1.0000 0.5403
1.0000 -1.0000 -0.9900
1.0000 1.0000 0.1086
-0.7313 0.6949 0.9573
0.5275 -0.4899 0.8270
-0.0091 -0.1010 1.6936
0.3031 0.5774 1.3670];
x = data(:, 1);
y = data(:, 2);
z = data(:, 3);

[x_show, y_show] = meshgrid(-1:.05:1);
n = size(x_show, 1);
z_show = zeros(n);
for i = 1 : n
    for j = 1 : n
        z_show(i, j) = Shepard(x_show(i, j), y_show(i, j), x, y, z);
    end
end
mesh(x_show, y_show, z_show);
hold on;
scatter3(x, y, z, 100, 'r.');
txt = xlabel('$x$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$y$');
set(txt, 'Interpreter', 'latex');
txt = zlabel('$z$');
set(txt, 'Interpreter', 'latex');
hold off;

function f = Shepard(x0, y0, x, y, z)
    p = 2;
    n = size(z, 1);
    dis = zeros(n, 1);
    for i = 1 : n
        dis(i) = norm([x(i), y(i)] - [x0, y0]);
        if dis(i) < 1e-15
            f = z(i);
            return
        end
    end
    w = dis.^(-p);
    w = w / sum(w);
    f = w' * z;
end
    
        