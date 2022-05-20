clear;

h = 1;
truth = 4 * exp(1);

T = {};
T{1} = (f(a) + f(b)) * h / 2;
m = 1;
result = T{1};
while 1
    m = m + 1;
    h = h / 2;
    T{m} = zeros(1, m);
    seq = 1 : 2 ^ (m - 2);
    T{m}(1) = (T{m - 1}(1) + sum(f(a + (2 * seq - 1) * h)) * h * 2) / 2;
    for k = 2 : m
        T{m}(k) = (4 ^ (k - 1) * T{m}(k - 1) - T{m - 1}(k - 1)) / (4 ^ (k - 1) - 1);
    end
    result = [result;T{m}(m)];
    if abs(T{m}(m) - T{m - 1}(m - 1)) < 1e-5
        break;
    end
end
plot(result-truth);


function y = f(x)
    y = x^3 * exp(x);
end