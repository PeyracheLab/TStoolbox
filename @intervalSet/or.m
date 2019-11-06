function s = or(a, b)

%  Union of two intervalSet's (overload of the | operator)
%
%  	USAGE
%  	s = or(a, b);
%   s = a | b;

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

s = union(a, b);

