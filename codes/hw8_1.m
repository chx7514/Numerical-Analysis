clear;
k = 0;
results = [];
truth = (exp(1)+cos(1)-sin(1)) / 2 - 1;
tol = 1e-10;
while 1
    int = 0;
    k = k + 1;
    h = 1 / k;
    for i = 0 : k - 1
        x = i * h;
        for j = 0 : k - i - 1
            y = j * h;
            int = int + rule_2(x, y, h);
        end
    end
    for i = 1 : k - 1
        x = i * h;
        for j = 1 : k - i
            y = j * h;
            int = int + rule_2(x, y, -h);
        end
    end
    results = [results; int];
    if k>1 && abs(results(end-1) - int) < tol
        break;
    end
end
plot(results);
line([1, k], [truth, truth],'color','r');
txt = xlabel('$k$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$value$');
set(txt, 'Interpreter', 'latex');
legend('composite quadrature', 'the right value of the intergration')
figure();
semilogy(abs(results - truth));
txt = xlabel('$k$');
set(txt, 'Interpreter', 'latex');
txt = ylabel('$\log|residual|$');
set(txt, 'Interpreter', 'latex');


function z = f(x, y)
   z = exp(x) * sin(y); 
end

% rule 1
% reverse needs to input -h
function int = rule_1(x, y, h)
    int = (f(x+h/2, y) + f(x, y+h/2) + f(x+h/2, y+h/2)) * h^2 / 6;
end

% rule 2
% reverse needs to input -h
function int = rule_2(x, y, h)
    int = (f(x+h*2/3, y+h/6) + f(x+h/6, y+h*2/3) + f(x+h/6, y+h/6)) * h^2 / 6;
end