function A = array(O, TimeUnits)

%  No comprendo
%
%  	USAGE:
%  	S = array(O, TimeUnits)%
%
%  	INPUTS:
%  	O - an intervalSet object
%  	TimeUnits - a units object or the abbreviation string
%
%  	OUTPUT:
%  	S - a N x 2 array of starting and end points for each interval in the set

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

if nargin>1
    warning('TimeUnits ignored in v2.0');
end


S = O.start(:);
E = O.stop(:);

A = [S E];

