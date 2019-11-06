function ft = FirstTime(O, TimeUnits)

%  First time of the intervalSet
%  	
%  	USAGE:
%  	ft = FirstTime(is, TimeUnits)
%  	
%  	INPUTS:
%  	O - an intervalSet object
%  	TimeUnits (optionnal) - a units object or the abbreviation string
%  	
%  	OUTPUTS:
%  	ft - the first time of the intervalSet
  
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
  
  ft = O.start(1);
  
%   TimeUnits = time_units(TimeUnits);
%   
%   cnvrt = convert(O.units, TimeUnits);
%   
%   if cnvrt ~= 1
%     ft = ft * cnvrt;
%   end
