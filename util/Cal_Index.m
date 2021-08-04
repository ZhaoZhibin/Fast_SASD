function [index] = Cal_Index(x, Params)
% This function creates the simulation containing impulses, harmonic
% and noise
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x:                          The generated weight vector
% A:                          Function handles for the transform A
% AH:                         Function handles for the inverse transform A
% Params: a struct contains all the parameters
%       Params.W_type:        The weight type: 'SESK', 'multi-scale PMI' or 'None'
%                             SESK: square envelope spectrum kurtosis (default)
%                             multi-scale PMI: multi-scale periodic modulation intensity
%                             None: the weight is inoperative
%       Params.Fs:            The sampling frequency of the simulation signal
%       Params.F_Interval:    The searching interval of the characteristic frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Weight:                     The generated weight vector

% Author : Zhibin Zhao
% Place  : Xi'an Jiaotong University
% Email  : zhibinzhao1993@gmail.com
% Date   : 2018.6

switch Params.index_type
    case 'None'
        index = 1;
    case 'SESK'
        [ yf, ~] = Hilbert_envelope(x , Params.Fs);
        xlen = length(x);
        NFFT = 2 ^ nextpow2(xlen);
        N = floor(Params.Fs / Params.Fc / 2) - 1;
        for i = 1 : N
            N1 = round(Params.Fc * i / (Params.Fs / NFFT));
            N_Interval1 = 5;
            Energy(i) = sum(yf(N1-N_Interval1:N1+N_Interval1));
        end      
        if sum(yf) == 0
            index = 0;
        else
            index = sum(Energy) / sum(yf);
        end
    otherwise
        error('Unknown method.')
end      
end


