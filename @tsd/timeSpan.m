function is = timeSpan(tsa)

%  Returns interval spanning the entire duration of a TSD, from the first
%  time point to the last time point. This is in contrast to tsd.timeInterval, 
%  which is the intervalSet the TSD is defined over. 
%
%  	USAGE
%  	is = timeSpan(tsa)
%
%  	INPUTS:
%  	tsa 	  - a tsd object
%
%  	OUTPUT:
%  	is - intervalSet containing the timestamp

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. 



is = intervalSet(StartTime(tsa), EndTime(tsa));
warning('tsd.timeSpan() returns the interval between the first and last time points. tsd.timeInterval returns the actual intervalSet.');

