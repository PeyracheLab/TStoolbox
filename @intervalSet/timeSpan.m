function tsp = timeSpan(is)

%  Returns the minimum continuous interval that contains the intervalSet
%  
%  	USAGE
%  	tsp = timeSpan(is) 
%  	
%  	INPUTS:
%  	is - an interval set
%  	
%  	OUTPUTS:
%  	tsp - the time span intervalSet
  
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

  
  st = Start(is);
  en = End(is);
  tsp = intervalSet(st(1), en(end));
  