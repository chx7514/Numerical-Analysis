% radix 3
function [X] = fft_3(x)
    n = size(x, 2);
    if n==3
        X=[x(1)+x(2)+x(3),...
            x(1)+exp(-1i*(2*pi*1/3))*x(2)+exp(-1i*(2*pi*2/3))*x(3),...
            x(1)+exp(-1i*(2*pi*2/3))*x(2)+exp(-1i*(2*pi*4/3))*x(3)];
    else
        w=exp(-1i*(2*pi*linspace(0,n/3-1,n/3)/n));
        x1=fft_3(x(1:3:n-2)); x2=w.*fft_3(x(2:3:n-1)); x3=w.^2.*fft_3(x(3:3:n));
        X=[x1+x2+x3,...
            x1+exp(-1i*(2*pi*1/3))*x2+exp(-1i*(2*pi*2/3))*x3,...
            x1+exp(-1i*(2*pi*2/3))*x2+exp(-1i*(2*pi*4/3))*x3];
    end
end