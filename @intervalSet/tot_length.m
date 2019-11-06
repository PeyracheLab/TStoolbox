function L = tot_length(O)

%  Returns total length of intervalSet
%  
%  	USAGE:
%  	L = tot_length(A)
%
%   or 
%
%   L = A.tot_length();
%  	
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson Aug 2017

L = sum(End(O) - Start(O));
