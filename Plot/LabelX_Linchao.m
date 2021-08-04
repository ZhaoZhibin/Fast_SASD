function [] = LabelX_Linchao(h_ap,String,xylim,pX)

global FontSize FontName;

% disp(num2str(FontSize))
% disp(FontName)

xlim_min = xylim(1);  xlim_max = xylim(2);
ylim_min = xylim(3);  ylim_max = xylim(4);

set(get(h_ap,'Xlabel'),'String',String, ...
    'FontSize',FontSize,'FontName',FontName, ...
    'position',[(xlim_max-xlim_min)/2+xlim_min,pX*(ylim_min-ylim_max)+ylim_min]);