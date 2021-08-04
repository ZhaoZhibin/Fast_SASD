function [ x1, x2 , cost ] = Convex_SASD( Sig , B , lam1 , lam2, pen, rho, eta, Nit)

if nargin < 8
    Nit = 100;       % Default value
end
if nargin < 7
    eta = 1;        % Default value
end
if nargin < 6
    rho = 0.005;        % Default value
end
if nargin < 5
    pen = 'abs';        % Default value
end


%% Initialization
y = Sig(:);
h = B; 
cost = zeros(1 , Nit);
N = length(y);
K = sum(B);
%% Define the dictionary D
NN = N;
truncate = @(x, N) x(1:N);
AH = @(x) fft(x, NN)/sqrt(NN);
A = @(X) truncate(ifft(X), N) * sqrt(NN);


normA = sqrt(N/NN);
lam1 = lam1 * normA;
x1 = AH(y);
x2 = y;
mu = 0.4;

%% Set the abs operator
a = 0.9*(lam1*eta)/(K*lam2*(1+lam1*eta));
[phi, wfun] = pen_fun(a, pen);

for iter = 1 : Nit
    xx = sqrt( conv(abs(x2).^2, h, 'full') );
    w = 1 ./ (abs(x2) + eps);
    cost(iter) = 0.5 * sum(abs(x2+real(A(x1))-y).^2) + lam2 * (sum(phi(xx)) + mu * rho * K * sum(abs(x2) .* w)) + lam1 * (sum(abs(x1))+eta/2*sum(abs(x1).^2));
    b = 1 ./ (wfun(xx) + eps);
    r = conv(b , h , 'valid');
    
    p1 = x1 - mu * AH(real(A(x1))+x2-y);
    p2 = x2 - mu * (real(A(x1))+x2-y) ;        
    q1 = 1 + mu*lam2 * r + eps;
    T = mu* lam2 * rho * K ./ q1 .* w;  
    x1 = softth(p1 , lam1*mu) ./ (1+eta*mu*lam1);
    x2 = softth(p2 ./ q1 , T);
    
end
x1 = real(A(x1));
