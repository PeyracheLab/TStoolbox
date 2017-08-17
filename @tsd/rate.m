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
    end
end

% opt_varargin = varargin;
% 
% defined_options = dictArray(  );
% 
% getOpt;



if ~isempty(iSet)
    tsa = Restrict(tsa, iSet);
end

t = tsa.t;
if ~isempty(t)
    
    if ~isempty(iSet)
        l = tot_length(tsa.timeInterval);
    elseif length(t)>1
        l = t(end) - t(1);
    else
        l = eps;
    end
    
    if l == 0
        l = eps;
    end
    r = length(t) / l;
else
    r = 0;
end