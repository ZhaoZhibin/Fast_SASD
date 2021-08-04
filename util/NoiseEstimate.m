function  Sigma = NoiseEstimate( Sin )
% Sigma = NoiseEstimate( Sin )
% Estimate the standard deviation of the noise
% Input : 
%          Sin : the original signal
% Output : 
%          Sigma : the standard deviation

NScale = 2;
Wname = 'sym8';
[C, L] = wavedec(Sin, NScale, Wname);              % wavelet decomposition
n = L(1);                                                              % approximation component
coef = C(n+1:end);
Sigma = median(abs(coef-median(coef))) / 0.6745;

end
% Made by Zhibin Zhao
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2017.02.15
