function [ RMSE ] = RMSE( Ori , Result )

% 
% Ori : Original Signal
% Result : the denoised signal

% RRMSE : Index
Ori = Ori(:);
Result = Result(:);
RMSE = sqrt(mean((Ori - Result).^2));

end

