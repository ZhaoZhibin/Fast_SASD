function [ Simulation ] = CreatSimulation( N , Fn , Fs )
% This function Creats a random simulation Signal
% Inputs:
%       N : the length of the signal
%       Fn : the fault frequency
%       Fs : the sampling frequency
% Output:
%       Simulation : the created signals


% Author : Zhibin Zhao
% Place : Xi'an Jiaotong University
% Email : zhaozhibin@stu.xjtu.edu.cn
% Date : 2017.10
Num = floor(N / floor(Fs / Fn));
slip = round(6000*(2*rand(Num,1)-1)*0.001);  % uniform distribution (-0.001,0.001)
F = 2000;
Simulation = zeros(N , 1);
K = floor(Fs / Fn);
Num = floor(N / K);
Interval = 20;
n = (0 : Interval-1) / Fs;
n = n';
for i = 1 : Num
    U = 1;
    Transient = zeros(Interval , 1); 
    for j = 1 : U
        A = 1;
        w = F;
        beta = 20;
        Transient = Transient + A*sin(2*pi*w*n + beta) .* exp(-1000*n);
    end 
    if i == 1
        Simulation((i-1)*K+1:(i-1)*K+Interval) = Transient;
    else
        Simulation((i-1)*K+1+slip(i):(i-1)*K+slip(i)+Interval) = Transient;
    end
end

end

