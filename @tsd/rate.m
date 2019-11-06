function r = rate(tsa, varargin)

% r = rate(tsa, iSet) returns average rate of a tsd object, measured in
% its internal intervalSet, or in the intersection of iSet with its
% internal intervalSet.
%
%
% INPUTS:
% tsa: a tsd object
% iSet: an intervalSet (optional)
%
% OUTPUTS:
% r: the rate
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017


iSet = [];
if ~isempty(varargin)
    if isa(varargin{1}, 'intervalSet')
        iSet = varargin{1};
        %         if length(varargin) > 2
        %             varargin = varargin(2:end);
        %         else
        %             varargin = {};
        %         end
    elseif isa(varargin{1}{1}, 'intervalSet')
        iSet = varargin{1}{1};
    end
else iSet = tsa.timeInterval;
end

if ~isempty(iSet)
    tsa = Restrict(tsa, iSet);
end

if ~isempty(tsa.t) && tot_length(tsa.timeInterval) > 0
    r = length(tsa.t) / tot_length(tsa.timeInterval);
else
    r = 0;
end