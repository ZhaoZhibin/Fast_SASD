function [WindowPosition11,h11] = Subfigure11_cm(wb,hb,margin_left,margin_right,margin_top,margin_bottom)
%% Figure position setting

if nargin < 6
	error('��ͼ�������������6��');
end
    
% % width and height of the subgraph box    
% wb = 300;    % wf: the Width of the Box
% hb = 150;    % hf: the Height of the Box 
% % margin for each subgraph    
% margin_left = 50;    % margin_left   ��߽����
% margin_right= 10;    % margin_right  �ұ߽����
% margin_top  = 10;    % margin_top    �ϱ߽����
% margin_bottom = 35;  % margin_Bottom �±߽����  


% width and height of the figure box  
WF = 1*(wb+margin_left+margin_right);   % WF: the Width of the Figure
HF = 1*(hb+margin_top+margin_bottom);   % HF: the Height of the Figure    
% width percentage and height percentage
wb_unit = wb/WF;
hb_unit = hb/HF; 
% margin percentage
ml_delta = margin_left/WF;
mr_delta = margin_right/WF;
mt_delta = margin_top/HF;
mb_delta = margin_bottom/HF;
wbox_unit = wb_unit + ml_delta + mr_delta;
hbox_unit = hb_unit + mt_delta + mb_delta;     

% axes position setting [left,bottom,width,heigth];
h11 = [ml_delta,                1-mt_delta-hb_unit,	wb_unit,	hb_unit];    
% h12 = [wbox_unit + ml_delta,    1-mt_delta-hb_unit,	wb_unit,	hb_unit];
% h22 = [wbox_unit + ml_delta,    1-mt_delta-hb_unit-hbox_unit,	wb_unit,	hb_unit];
% figure position setting;
WindowPosition11 = [3,3,WF,HF]; 