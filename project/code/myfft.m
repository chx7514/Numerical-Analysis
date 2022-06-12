function [X] = myfft(x)
    n = length(x);
    if n < 2
        ME = MException('MyComponent:lentherror', 'length of x is smaller than 2'); 
        throw(ME);
    end
    if isprime(n)
        if n == 2
            X = fft_2(x);
        elseif n == 3
            X = fft_3(x);
        elseif n == 5
            X = fft_5(x);
        else
            X = rader(x);
        end
    else
        X = Cooley_Tukey(x);
    end
end
    