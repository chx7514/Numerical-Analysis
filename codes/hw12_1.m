clear;
for j=1:4
    n = 4 ^ j;
    h = 1 / n;
    x = linspace(0, 1, n + 1);
    f=zeros(1,n+1); f(n+1)=1;
    for i=2:n
        x2=x(i+1); x1=x(i); x0=x(i-1);
        f1=@(x)(x-x0)/h.*x.^2;
        f2=@(x)(x2-x)/h.*x.^2;
        f(i)=integral(f1,x0,x1)+integral(f2,x1,x2);
    end
    A=diag([-ones(1,n-1)*1/h+1/6*h,0],-1)+diag([1,ones(1,n-1)*2/h+2/3*h,1])+diag([0,-ones(1,n-1)*1/h+1/6*h],1);
    u=A\f';
    x_display = linspace(0, 1, 1000);
    y_display = zeros(1, 1000);
    k = 2;
    for i = 1 : 1000
        if x_display(i) > x(k)
            k = k + 1;
        end
        y_display(i) = u(k) * (x_display(i) - x(k-1)) / h + u(k - 1) * (x(k) - x_display(i)) / h;
    end
    subplot(2, 4, j);
    plot(x_display, y_display);
    hold on;
    plot(x_display,x_display.^2+2-2/(exp(1)+1)*exp(x_display)-2/(exp(-1)+1)*exp(-x_display))
    hold off;
    legend("myfunc","precise");
    title("n="+num2str(n));
    subplot(2,4,j+4);
    plot(x_display,abs(x_display.^2+2-2/(exp(1)+1)*exp(x_display)-2/(exp(-1)+1)*exp(-x_display)-y_display));
    legend("error");
    title("n="+num2str(n));
end