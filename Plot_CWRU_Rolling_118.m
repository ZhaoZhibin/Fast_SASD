clc
clear all
close all
addpath(genpath(fileparts(mfilename('fullpath'))));
%% Figure initialization
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




[ ff1, f1 ] = Dofft( Sig_Combine , Fs , 0);
[ yf1, f1 ] = Hilbert_envelope(Sig_Combine , Fs , 1);

xlen = length(Sig_Combine);
NFFT = 2 ^ nextpow2(xlen);
for i = 1 : 3
    N1 = round(F_rolling * i / (Fs / NFFT));
    N_Interval1 = 4;
    [Points1(i), ~] = max(yf1(N1-N_Interval1:N1+N_Interval1));
    Index1 = find(yf1 == Points1(i));
    Points_Index1(i) = f1(Index1); 
end
% 
for i = 1 : 2
    N1 = round(Fr * i / (Fs / NFFT));
    N_Interval1 = 8;
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
ph(1) = plot(t, Sig_Combine, 'b-', 'LineWidth', LineWidth);
hold off
% box on
% legend1 = legend(ph, 'Noisy signal' , 'Noise-free signal');
% set(legend1,'location','best','Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
% legend boxoff
xlim_min = min(t); xlim_max = max(t);
ylim_min = min(Sig_Combine)*1.2;            ylim_max = max(abs(Sig_Combine))*1.2;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Tstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);

annotation('textbox',[0 1 0.03 0.03],'String',{'(a)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('21a_CWRU_Experiment_T',FlagFigureAutoSave,currentFolder)



%% Print the freqeuncy domain
figure(4);clf;
set(gcf, 'NumberTitle','off','Name','Experiment_Enlargement');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index1, Points1, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(Points_Index2, Points2, 'g*', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(3) = plot(f1, yf1, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'BSF', 'RF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 900;
ylim_min = 0;            ylim_max = max(abs(yf1))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(b)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('21b_CWRU_Experiment_Enlargement',FlagFigureAutoSave,currentFolder)

