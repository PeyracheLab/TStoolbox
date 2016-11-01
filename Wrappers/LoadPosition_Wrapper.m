function [X,Y,GoodRanges,wstruct] = LoadPosition_Wrapper(fbasename,varargin)

% loads position and speed from a position file file (ending in .whl)
%
% USAGE
%     [X,Y,V,GoodRanges,wstruct] = HeadDirectionWhl(fbasename)
%     
% INPUT:
%     fbasename: session file basename
%	  pixelConv (optional): no pixel to cm conversion
% OUTPUT:
%     X: a tsd object of x position values
%     Y: a tsd object of y position values
%     V: a tsd object of  position values
%     GoodRanges: a intervalSet object where LEDs were successfully detected

% Adrien Peyrache, 2011

pixelConv = 1;
if ~isempty(varargin)
    pixelConv = varargin{1};
end

if exist([fbasename '.whl'],'file')
    fprintf('Load whl file\n')
    [whl,t,GR] = LoadPosition(fbasename);
elseif exist([fbasename '.pos'],'file')
    fprintf('Load pos file\n')
    [whl,t,GR] = LoadPosition_Pos(fbasename);
end

[folder dumy dumy]  = fileparts(fbasename);
if ~isempty(folder)
    folder =  [folder filesep];
end
bin2cms = 0;

if exist([folder 'Analysis/GeneralInfo.mat'],'file')
    warning off
    load([folder 'Analysis/GeneralInfo.mat'],'bin2cms');
    warning on
    if bin2cms & pixelConv
        whl = bin2cms*whl;
    end
end

if ~bin2cms
    warning('Spatial data not calibrated in cms!')
    bin2cms = 1;
end;
if size(whl)>2
    X = nanmean([whl(:,1),whl(:,3)]')';
    Y = nanmean([whl(:,2),whl(:,4)]')';
else
    X = whl(:,1);
    Y = whl(:,2);
end

%gw = gausswin(smoothWidth);
%gw = gw/sum(gw(:));
warning off
goodEp = intervalSet(GR(:,1),GR(:,2));
goodEp = mergeCloseIntervals(goodEp,1);
warning on

X = tsd(t,X);
Y = tsd(t,Y);

GoodRanges = intervalSet(GR(:,1),GR(:,2));

if nargout==4
    wstruct.t = t;
    wstruct.whl = whl/bin2cms;
    wstruct.GR = GR;
end