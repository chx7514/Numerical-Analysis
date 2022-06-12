function [a] = findPrimitiveRoot(N)
    factors = factor(N - 1);
    a = 1;
    while 1
        a = a + 1;
        if a >= N
            break;
        end
        if gcd(a, N) ~= 1
            continue;
        end
        flag = 1;
        for i = 1 : length(factors)
            if expmod(a, (N-1)/factors(i), N) == 1
                flag = 0;
                break;
            end
        end
        if flag
            break;
        end
    end
end