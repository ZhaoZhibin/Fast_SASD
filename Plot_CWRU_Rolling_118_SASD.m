clc
clear all
close all
addpath(genpath(fileparts(mfilename('fullpath'))));
%% Figure initialization
global FontSize FontName;
Tstring =  'Time(s)'; 
Fstring = 'Frequency(Hz)';
Astring =  'Amp';
FontSize = 9;   FontName = 'Times New Roman';
MarkerSize = 4;  LineWidth = 1;
%%
FlagFigureAutoSave = 1;
currentFolder = pwd;


load 118.mat

Fs = 12000;
Fr = X118RPM/60;
F_rolling = Fr*4.7135;
Sig_N = X118_DE_time(12000:12000*2, 1);
N = length(Sig_N);
t = (0 : N-1)/Fs;
Sig_Combine = Sig_N;

%%
K1 = 1;    % this is the dimension of the binary sequence
fc = F_rolling;
N1 = 4;
N0 = round(Fs / fc) - N1;   % N0 + N1 = fs / fc; fs:sampling frequency; fc: fault characteristic frequency
M = 4;
K = (N0 + N1) * (M-1) + N1;
B = binaryblock( K1 , N0 , N1 , M);
Nit = 50;                       % Nit : number of iterations

Sigma = NoiseEstimate( Sig_Combine );


Params.index_type = 'SESK';
Params.Fs = Fs;
Params.Fc = F_rolling;
lam1 = Sigma*sqrt(2*log(N));
rho = 0.0009235;
lam2 = (0.272*Sigma + 0.044);   
pen = 'mcp';
[ x1, x2 , cost, best_trade_off ] = Fast_adaptive_SASD( Sig_Combine, B , lam1 , lam2, pen, rho, Params);






% [ ff1, f2 ] = Dofft( Sig_Combine , Fs , 0);
[ yf1, f1 ] = Hilbert_envelope(x1 , Fs , 1);
[ yf2, f2 ] = Hilbert_envelope(x2 , Fs , 1);


FCER_Nonconvex = Cal_Index(x2, Params);

xlen = length(x2);
NFFT = 2 ^ nextpow2(xlen);
for i = 1 : 3
    N1 = round(fc * i / (Fs / NFFT));
    N_Interval1 = 4;
    [Points1(i), ~] = max(yf2(N1-N_Interval1:N1+N_Interval1));
    Index1 = find(yf2 == Points1(i));
    Points_Index1(i) = f1(Index1); 
end

for i = 1 : 3
    N1 = round(Fr * i / (Fs / NFFT));
    N_Interval1 = 4;
    [Points2(i), ~] = max(yf1(N1-N_Interval1:N1+N_Interval1));
    Index2 = find(yf1 == Points2(i));
    Points_Index2(i) = f1(Index2); 
end


x_side = 0.3;
y_side = 0.16;
%% Print the time domain
[WindowPosition,h1] = Subfigure11_cm(5, 1.5, 1.2, 0.3, 0.5, 0.9);
figure(1);clf;
set(gcf, 'NumberTitle','off','Name','Experiment_Time');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(t, x2, 'b-', 'LineWidth', LineWidth);
hold off
% box on
% legend1 = legend(ph, 'Noisy signal' , 'Noise-free signal');
% set(legend1,'location','best','Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
% legend boxoff
% title(['FCER=', num2str(FCER_Nonconvex)],'FontSize',FontSize,'FontName',FontName);
xlim_min = min(t); xlim_max = max(t);
ylim_min = min(x2)*1.2;            ylim_max = max(abs(x2))*1.2;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Tstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);

annotation('textbox',[0 1 0.03 0.03],'String',{'(a)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('22a_CWRU_Experiment_SASD',FlagFigureAutoSave,currentFolder)

%% Print the freqeuncy domain
figure(2);clf;
set(gcf, 'NumberTitle','off','Name','Experiment_Enlargement');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index1, Points1, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f2, yf2, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'BSF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 900;
ylim_min = 0;            ylim_max = max(abs(yf2))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(b)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('22b_CWRU_Experiment_Enlargement',FlagFigureAutoSave,currentFolder)

%% Print the time domain
figure(3);clf;
set(gcf, 'NumberTitle','off','Name','Experiment_Time');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(t, x1, 'b-', 'LineWidth', LineWidth);
hold off
% box on
% legend1 = legend(ph, 'Noisy signal' , 'Noise-free signal');
% set(legend1,'location','best','Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
% legend boxoff
% title(['RMSE=', num2str(RMSE_Harmonic)],'FontSize',FontSize,'FontName',FontName);
xlim_min = min(t); xlim_max = max(t);
ylim_min = -max(abs(x1))*1.2;            ylim_max = max(abs(x1))*1.2;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Tstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);

annotation('textbox',[0 1 0.03 0.03],'String',{'(c)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('22c_CWRU_Experiment_SASD',FlagFigureAutoSave,currentFolder)

%% Print the freqeuncy domain
figure(4);clf;
set(gcf, 'NumberTitle','off','Name','Experiment_Enlargement');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index2, Points2, 'g*', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f1, yf1, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'RF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 900;
ylim_min = 0;            ylim_max = max(abs(yf1))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(d)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('22d_CWRU_Experiment_Enlargement',FlagFigureAutoSave,currentFolder)


