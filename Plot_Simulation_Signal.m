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

Sig_Combine = Impulse + Harmonic + AMFM + Noise;

[ ff1, f2 ] = Dofft( Sig_Combine , Fs , 0);
[ yf1, f1 ] = Hilbert_envelope( Sig_Combine , Fs , 1);


xlen = length(Sig_Combine);
NFFT = 2 ^ nextpow2(xlen);
for i = 1 : 2
    N1 = round(1000 * i / (Fs / NFFT));
    N_Interval1 = 8;
    [Points1(i), ~] = max(ff1(N1-N_Interval1:N1+N_Interval1));
    Index1 = find(ff1 == Points1(i));
    Points_Index1(i) = f1(Index1); 
end

for i = 1 : 1
    N1 = round(180 * i / (Fs / NFFT));
    N_Interval1 = 4;
    [Points2(i), ~] = max(yf1(N1-N_Interval1:N1+N_Interval1));
    Index2 = find(yf1 == Points2(i));
    Points_Index2(i) = f1(Index2); 
end


x_side = 0.3;
y_side = 0.1;
%% Print the time domain
[WindowPosition,h1] = Subfigure11_cm(5, 1.5, 1, 0.5, 0.3, 0.9);
figure(1);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Time');
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
ylim_min = -max(abs(Sig_Combine))*1.2;            ylim_max = max(abs(Sig_Combine))*1.2;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Tstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);

annotation('textbox',[0 1 0.03 0.03],'String',{'(a)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('4a_Simulation_Time',FlagFigureAutoSave,currentFolder)

%% Print the freqeuncy domain
figure(2);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Frequency');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index1, Points1, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f2, ff1, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'CF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 4000;
ylim_min = 0;            ylim_max = max(abs(ff1))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(b)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('4b_Simulation_Frequency',FlagFigureAutoSave,currentFolder)



%% Print the envelope spectrum
figure(3);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Envelope');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index2, Points2, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f1, yf1, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'AMF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 4000;
ylim_min = 0;            ylim_max = max(abs(yf1))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(c)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('4c_Simulation_Envelope',FlagFigureAutoSave,currentFolder)


%% Print the freqeuncy domain
figure(4);clf;
set(gcf, 'NumberTitle','off','Name','Simulation_Enlargement');
set(gcf, 'Units', 'centimeters');
set(gcf,'position',WindowPosition);
set(gcf, 'PaperPositionMode', 'auto');   
h1_ap=axes('position',h1); 
hold on
ph(1) = plot(Points_Index2, Points2, 'ro', 'LineWidth', LineWidth,'MarkerSize',MarkerSize);
ph(2) = plot(f1, yf1, 'b-', 'LineWidth', LineWidth);
hold off
legend1 = legend(ph, 'AMF');
set(legend1,'location', 'best', 'Orientation','horizontal', 'FontSize',FontSize,'FontName',FontName)
legend boxoff

xlim_min = 0; xlim_max = 500;
ylim_min = 0;            ylim_max = max(abs(yf1))*1.3;%max(abs(yf1))*1.3;  
xylim = [xlim_min,xlim_max,ylim_min,ylim_max]; axis(xylim);

LabelX_Linchao(h1_ap,Fstring,xylim,x_side);
LabelY_Linchao(h1_ap,Astring,xylim,y_side);
set(h1_ap,'FontSize',FontSize,'FontName',FontName);


annotation('textbox',[0 1 0.03 0.03],'String',{'(d)'},'FontSize',FontSize+2,'FontName',FontName,'FontWeight','bold','FitBoxToText','off','LineStyle','none');
% save figure
SaveFigureLinchao('4d_Simulation_Enlargement',FlagFigureAutoSave,currentFolder)