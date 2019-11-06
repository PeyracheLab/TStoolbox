function SO = mapArray(S, cmd_string, varargin)

% Applies function on each element of the array
%  
%  	USAGE:
%  	SO = mapArray(S, cmd_string, arg1, ..., argN)
%  
% Similarly to Python's function, map applies the commands indicated in
% cmd_stirng to each elements of the tsdArray S. In cmd_string, the input
% tsd array must be referred to as TSA. The output of the commands must
% be a numerical array, referred to as AO. Results are cat horizontally
%  Further arguments may be used in cmd_string, and
% may be passed to map as arguments following cmd_string. In cmd_string,
% they must be referred to %1, %2, etc. Admittedly a dirty hack, but the
% only way to mimick passing a function object... 

% copyright (c) 2004 Francesco P. Battaglia
% modified by Adrien Peyrache, 2007
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html  

expand_cmd_string
keyboard
%    SO = zeros(size(S));

  for i = 1:length(S)
    TSA = S.C{i};
    eval(['AO = ' cmd_string ';']);
    SO(i,:) = AO;
  end
