function tss = subset(tsa, ix)

%  Returns tsd of a subset of input
%  
%  	USAGE:
%  	tss = subset(tsa, ix); 
%  	
%  	INPUTS:
%  	ts - an input object
%  	ix - an array of indices 
%  	
%  	OUTPUTS: 
%  	tss - a tsd containing the point in tsa indicated by ix. The
%  	timeInterval for this TSD will be the same as the input TSD.

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added support for timeInterval in TSD.
  
tss = tsd(tsa.t(ix), SelectAlongFirstDimension(Data(tsa), ix), 'timeInterval', tsa.timeInterval);
  
  