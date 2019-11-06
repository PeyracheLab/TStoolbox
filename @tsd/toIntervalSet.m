function is = toIntervalSet(tsa)

%  Returns the intervalSet delimited by the timestamps of a TSD
%  
%  	USAGE:
%  	is = toIntervalSet(tsa) 
%  	
%  	INPUTS:
%  	tsa - a tsd object
%  	
%  	OUTPUTS:
%   is - the intersection of the TSD's internal intervalSet and the
%   intervalSet where each interval is of the form [tsd(i) tsd(i+1)].


% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added support for intervalSets in TSDs.
  
t = tsa.t;

is = intervalSet(t(1:end-1), t(2:end));
is = is.intersect(tsa.timeInterval);
