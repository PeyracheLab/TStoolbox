function m = mean(tsa, epoch)

% Returns the mean of data in tsd object
%
% USAGE:
% m = mean(tsa, epoch)
%
% INPUTS:
% tsa: a tsd object
% epoch: an intervalSet object (optional)
%
% OUTPUTS:
% m: the mean rate
%
% copyright (c) 2004 Francesco P. Battaglia,
% modified 2009 by Adrien Peyrache adrien.peyrache@gmail.com
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Fixed intervalSet bug.

if nargin<2    
    m = mean(tsa.data, 1);
else
    tsb = tsa.Restrict(epoch);
    m = mean(tsb.data, 1);
end