function T1 = StartTime(tsa)

% Returns first timestamp
%  	
%  	USAGE:
%  	T1 = StartTime(tsa)
%  	
% the current version is an evolution of A. David Redish's code
% changes copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
% released under the GPL 
%
% v2.0 Luke Sjulson, Aug 2017 - units support removed

  
T1 = tsa.t(1);

