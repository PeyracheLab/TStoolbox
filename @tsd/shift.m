function A = shift(tsa, shift)

%  Shifts TSD
%
%  	USAGE:
%  	A = shift(tsa, shift)
%
%  	INPUTS:
%  	A - a TSD object
%  	shift - the time to shift the TSD by
%
% Luke Sjulson, Aug 2017


A = tsd(tsa.t + shift, tsa.data, 'timeInterval', tsa.timeInterval.shift(shift));
