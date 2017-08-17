function t = Data(tsa)
% Returns the timestamps of TS object
%
%  	t = Data(tsa) returns the timestamps of the TS object tsa
%
%  	t = Data(tsa,tsb) returns the timestamps of the TS object tsa restricted on the timestamps of tsb (and aligned 'prev')
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Removed units.

%   if nargin == 1
%     t = Range(tsa.tsd);
%   else
%     t = Range(Restrict(tsa.tsd, tsb, 'align', 'prev'));
%   end

t = tsa.t;