function lt = LastTime(O, TimeUnits)

%  Returns last time of an intervalSet
%  	
%  	USAGE:
%  	lt = LastTime(is, TimeUnits)
%  	
%  	INPUTS:
%  	O - an intervalSet object
%  	TimeUnits - a units object or the abbreviation string
%  	
%  	OUTPUTS:
%  	lt - the last time of the intervalSet
  
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
  
  
%   if nargin < 1 | nargin > 2
%     error('Call with one or two arguments');
%   end
%   
%   if nargin == 1
%     TimeUnits = time_units('ts');
%   end  
  
  lt = O.stop(end);
  
%   TimeUnits = time_units(TimeUnits);
%   
%   cnvrt = convert(O.units, TimeUnits);
%   
%   if cnvrt ~= 1
%     lt = lt * cnvrt;
%   end
