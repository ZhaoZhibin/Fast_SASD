function SaveFigureLinchao(FileName,flag,Folder)
% 
% Usage Example
% currentFolder = pwd;
% SaveFigureLinchao('Figure1',1,currentFolder)


if flag == 1
    set(gcf,'paperpositionmode','auto');

    % EPS Figure
    currentFolder = [Folder,'/Figures/Figure in EPS'];
    cd(currentFolder)
    xxx = [FileName,'.eps'];
    print(gcf,'-depsc',xxx); % '-r600',
   
    % TIF Figure
    currentFolder = [Folder,'/Figures/Figure in TIF'];
    cd(currentFolder)
    
    xxx = [FileName,'.tif'];
    print(gcf,'-dtiffn',xxx); 
else
    return
end

cd(Folder)
return
