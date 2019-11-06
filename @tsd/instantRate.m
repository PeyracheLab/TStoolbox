function ir = instantRate(tsa)

%  Computes instantaneous rate as the inverse of inter-event interval
%
%  	USAGE:
%  	ir = instantRate(tsa)
%
%  	INPUTS:
%  	tsa 	  - a tsd object
%
%  	OUTPUT:
%  	ir - a tsd object where the data contains the instantaneous rate
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0 Luke Sjulson, Aug 2017 - removed units, added timeInterval

ir = tsd(tsa.t(1:end-1), 1./diff(tsa.t), 'timeInterval', tsa.timeInterval);

