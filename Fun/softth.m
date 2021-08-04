% Define the soft threshold function
function y = softth(x,tau)
% y:   is the signal after hard-threshold 
% x:   is the original signal 
% tau: is the threshold
y = sign(x).*max(abs(x)-tau,0);
end

% Made by Zhibin Zhao
% Contact with zhaozhibin@stu.xjtu.edu.cn
% Date: 2016.09.13