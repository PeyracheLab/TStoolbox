function sz = size(O, varargin)

% Returns size of tsdArray (overlaod of size function)
%  
%  	USAGE:
%  	sz = size(O) returns 
%  	sz = size(O,i) returns size along the ith dimension

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

  if ~isempty(varargin)
    sz = size(O.C, varargin{:});
  else
    sz = size(O.C);
  end
  