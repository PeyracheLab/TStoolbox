function A = shift(O, shift)

%  Shifts intervalSet
%  	
%  	USAGE:
%  	A = shift(A, shift) 
%  	
%  	INPUTS:
%  	A - an intervalSet object
%  	shift - the time to shift the intervalSet of

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

%   if nargin < 2 | nargin > 3
%     error('Call with two or three arguments');
%   end
%   
%   if nargin == 2
%     TimeUnits = time_units('ts');
%   end  
%   
%   cnvrt = convert(O.units, TimeUnits)
%   
%   shift = shift * cnvrt;
  
  A = intervalSet(O.start + shift, O.stop + shift);
  
  