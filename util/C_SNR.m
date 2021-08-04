function [ SNR ] = C_SNR( Sig , NSig )
% [ SNR ] = C_SNR( Sig , NSig )
% Calculate the signal to noise ratio
% Input : 
%          Sig : the original signal
%          NSig : the signal with noise
% Output : 
%          SNR : Signal to Noise Ratio
Sig = Sig(:);
NSig = NSig(:);
SNR = 0;  
Ps = sum(sum((Sig - mean(mean(Sig))).^2));      % Signal power 
Pn = sum(sum((Sig - NSig).^2));                         % Noise power 
SNR = 10 * log10(Ps / Pn);                                    % Signal to Noise Ratio
end
% Made by Zhibin Zhao
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2016.12.11

