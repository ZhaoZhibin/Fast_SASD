function [ x1, x2 , cost, best_trade_off ] = Fast_adaptive_SASD( Sig , B , lam1 , lam2, pen, rho, Params)
% This function realizes the fast adaptive  sparsity-assisted signal decomposition (Fast_adaptive_SASD)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Input %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sig:                        The input signal
% B:                          The binary sequence 
% lam1:                       The trade-off parameter calculated via the formula (34)
% lam2:                       The trade-off parameter calculated via the formula (34)
% pen:                        The penlty function listed in pen_funn.m
% rho:                        The PSWAG parameter shown in formula (3)
% eta:                        The elastic net parameter shown in formula (5)
% Params: a struct contains all the parameters
%       Params.W_type:        The weight type: 'SESK', or 'None'
%                             SESK: square envelope spectrum kurtosis (default)
%                             None: the weight is inoperative
%       Params.Fs:            The sampling frequency of the simulation signal
%       Params.F_Interval:    The searching interval of the characteristic frequency
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% x1:                         The separated discrete frequency components
% x2:                         The separated periodic impulse components
% cost:                       The cost values
% best_trade_off:             The optimal trade-off parameters

% Author : Zhibin Zhao
% Place  : Xi'an Jiaotong University
% Email  : zhibinzhao1993@gmail.com
% Date   : 2020.6
    b = 1;
    a = 0;
    epsilon = 0.01;
    trade_off1 = a + 0.382 * (b - a); 
    lam_use1 = trade_off1*lam1;      
    lam_use2 = (1-trade_off1)*lam2;  
    [~, x2 , ~] = Fast_SASD(Sig, B, lam_use1, lam_use2, pen, rho);
    f1 = Cal_Index(x2, Params);

    trade_off2 = a + 0.618 * (b - a); 
    lam_use1 = trade_off2*lam1;      
    lam_use2 = (1-trade_off2)*lam2;  
    [~, x2 , ~] = Fast_SASD(Sig, B, lam_use1, lam_use2, pen, rho);
    f2 = Cal_Index(x2, Params);
    
    while(abs(b - a) > epsilon)
        if f1 > f2 
            b = trade_off2; 
            trade_off2 = trade_off1; 
            f2 = f1;
            trade_off1 = a + 0.382 * (b - a); 
            lam_use1 = trade_off1*lam1;      
            lam_use2 = (1-trade_off1)*lam2;  
            [~, x2 , ~] = Fast_SASD(Sig, B, lam_use1, lam_use2, pen, rho);
            f1 = Cal_Index(x2, Params);
        else
            a = trade_off1;
            trade_off1 = trade_off2;
            f1 = f2;
            trade_off2 = a + 0.618 * (b - a);
            lam_use1 = trade_off2*lam1;      
            lam_use2 = (1-trade_off2)*lam2;  
            [~, x2 , ~] = Fast_SASD(Sig, B, lam_use1, lam_use2, pen, rho);
            f2 = Cal_Index(x2, Params);
        end

    end

    best_trade_off = (a + b) / 2;
    lam_use1 = best_trade_off*lam1;      
    lam_use2 = (1-best_trade_off)*lam2;  
    [x1, x2 , cost] = Fast_SASD(Sig, B, lam_use1, lam_use2, pen, rho);
end
