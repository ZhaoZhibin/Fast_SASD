clc
clear all
close all
rng('default');
rng(25);
addpath(genpath(fileparts(mfilename('fullpath'))));
%% Figure initialization
global FontSize FontName;
Tstring =  'Time (s)'; 
Fstring = 'Frequency (Hz)';
Astring =  'Amp';
FontSize = 9;   FontName = 'Times New Roman';
MarkerSize = 4;  LineWidth = 1;
%%
FlagFigureAutoSave = 1;
currentFolder = pwd;
%% Parameters Setting
Fs = 16000;
N = 8000;
t = (0 : N-1) / Fs;
t = t(:);  
AMFM = (1 + 0.5*cos(2*pi*180*t)) .* cos(2*pi*1000*t + 0.5*cos(2*pi*35*t))...
    + (0.5 + 0.5*cos(2*pi*360*t)) .* cos(2*pi*2000*t + 0.5*cos(2*pi*70*t));
Harmonic = 1 * cos(2*pi*180*t) + cos(2*pi*360*t);
AMFM = AMFM * 0.5;
Harmonic = Harmonic * 0.5;

Fn = 100;
Impulse = CreatSimulation(N , Fn , Fs);
Sigma = 0.5;
Noise = Sigma * randn(N ,1);
Frequency = Harmonic + AMFM;
Sig_Combine = Impulse + Frequency + Noise;


%%
K1 = 1;    % this is the dimension of the binary sequence
N0 = 156;   % N0 + N1 = fs / fc; fs:sampling frequency; fc: fault characteristic frequency
N1 = 4;
M = 4;
K = (N0 + N1) * (M-1) + N1;
B = binaryblock( K1 , N0 , N1 , M);
Nit = 50;                       % Nit : number of iterations

%%
load trade_off.mat
Sigma_tmp_Harmonic = squeeze(RMSE_Value_Harmonic(5, :, :));
Sigma_tmp_Impulse = squeeze(RMSE_Value_Impulse(5, :, :));
Harmonic_tmp = mean(Sigma_tmp_Harmonic);
Impulse_tmp = mean(Sigma_tmp_Impulse);
RMSE_tmp = Harmonic_tmp + Impulse_tmp;
[~, index_best] = min(RMSE_tmp);
trade_off_tmp = trade_off(index_best);

%%
lam1 = trade_off_tmp*Sigma*sqrt(2*log(N));          
rho = 0.0009235;
lam2 = (1-trade_off_tmp)*(0.27*Sigma + 0.044);   
pen = 'mcp';
[x1, x2 , cost1] = Fast_SASD(Sig_Combine, B, lam1, lam2, pen, rho);
pen = 'abs';
[x3, x4 , cost2] = Convex_SASD(Sig_Combine, B, lam1, lam2, pen, rho);

P.index_type = 'SESK';
P.Fs = Fs;
P.Fc = Fn;
FCER_Nonconvex = Cal_Index(x2, P);
[Kur, Skur] = New_Index(x2, Fn, Fs);
% [ ff1, f2 ] = Dofft( Sig_Combine , Fs , 0);
[ yf1, f1 ] = Hilbert_envelope(x1 , Fs , 1);
[ yf2, f2 ] = Hilbert_envelope(x2 , Fs , 1);

xlen = length(x2);
NFFT = 2 ^ nextpow2(xlen);
for i = 1 : 8
    N1 = round(100 * i / (Fs / NFFT));
    N_Interval1 = round(100 * i * 0.03 / (Fs / NFFT));
    [Points1(i), ~] = max(yf2(N1-N_Interval1:N1+N_Interval1));
    Index1 = find(yf2 == Points1(i));
    Points_Index1(i) = f1(Index1); 
end


x_side = 0.3;
y_side = 0.16;
%% Print the time domain
[WindowPosition,h1] = Subfigure11_cm(5, 1.5, 1.2, 0.3, 0.5, 0.9);
figure(1);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Time');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(t, x2, 'b-', 'LineWidth', LineWidth);
ph(2) = plot(t, x4, 'r-', 'LineWidth', LineWidth);
hold off
box off
legend1 = legend(ph, 'Non-convex' , 'Convex');
set(legend1,'location','best','Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff
title(['FCER=', num2str(FCER_Nonconvex), '; EK=', num2str(Kur)],'FontSize',FontSize,'FontName',FontName);
xlim_min = min(t); xlim_max = max(t);
ylim_min = min(x2)*1.05;            ylim_max = max(abs(x2))*1.5;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Tstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);

annotation('textbox',[0 1 0.03 0.03],'String',{'(a)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('6a_Simulation_SASD',FlagFigureAutoSave,currentFolder)

%% Print the freqeuncy domain
figure(2);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Enlargement');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index1, Points1, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f2, yf2, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'BPFO');
set(legend1,'location','best','Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff
xlim_min = 0; xlim_max = 900;
ylim_min = 0;            ylim_max = max(abs(yf2))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(b)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('6b_Simulation_Enlargement',FlagFigureAutoSave,currentFolder)

