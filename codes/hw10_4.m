clear;
N = 100;
h = 1 / N;
L = 1;
x = (0:(N-1))*h;
[X, Y] = meshgrid(x);
sig = 0.1;
rsq = (X-0.5*L).^2 + (Y-0.5*L).^2;
sigsq = sig^2;
f = exp(-rsq/(2*sigsq)).*(rsq - 2*sigsq)/(sigsq^2);
f = -f;
real_U = exp(-rsq/(2*sigsq));
mesh(X,Y,real_U);

F = fft2(f);
k = (2*pi)*[0:(N/2-1) (-N/2):(-1)];
[KX, KY] = meshgrid(k,k);
delsq = KX.^2 + KY.^2;
delsq(1,1) = 1;
u = ifft2(F./delsq);
u = u - u(1,1);
figure();
mesh(X,Y,real(u));

errmax = norm(u-real_U,inf)