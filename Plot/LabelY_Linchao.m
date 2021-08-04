function [] = LabelY_Linchao(h_ap,String,xylim,pY)

global FontSize FontName;

% disp(num2str(FontSize))
% disp(FontName)

xlim_min = xylim(1);  xlim_max = xylim(2);
ylim_min = xylim(3);  ylim_max = xylim(4);

set(get(h_ap,'Ylabel'),'String',String, ...
    'FontSize',FontSize,'FontName',FontName, ...
    'position',[pY*(xlim_min-xlim_max)+xlim_min,(ylim_max-ylim_min)/2+ylim_min]);
% set(get(h_ap,'Ylabel'),'String',String,'Interpreter','LaTex', ...
%     'FontSize',FontSize,'FontName',FontName, ...
%     'position',[pY*(xlim_min-xlim_max)+xlim_min,(ylim_max-ylim_min)/2+ylim_min]);