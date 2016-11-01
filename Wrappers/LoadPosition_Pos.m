function [whl,t,GoodRanges] = LoadPosition_Pos(fbasename)

% Intermediate wrapper, should not be used directly
%
% USAGE
% [whl,t,GoodRanges,ep] = LoadPosition(fbasename)
% 
% OUTPUT:
%   whl: the position matrix
%   t: time vector
%   Good Ranges: 

fid     = fopen([fbasename '.pos']);
whlt    = fscanf(fid,'%f\t%f\t%f\t%f\t%f\n');
fclose(fid);
whlt = reshape(whlt,5,[])';
whlt(isnan(whlt)) = -1;
[whl,GoodRanges] = CleanWhlForR(whlt(:,2:end));

t = whlt(:,1);
GoodRanges = [t(GoodRanges(:,1)) t(GoodRanges(:,2))];
