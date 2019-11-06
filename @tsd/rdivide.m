function s = rdivide(a,b)

%  Overload of the ./ operator for two tsd objects
%
%  	USAGE:
%  	tso = rdivide(tsa,tsb)
%
%  	the ./ operator is defined to return a tsd with same timestamps and
%  	data that are the ratio of the data. Returns error if timestamps of the
%  	two object don't coincide. Can also be used on a scalar and a TSD.

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added support for scalar ./ tsd and
% intervalSets in TSDs.

if (isa(a, 'tsd') && isa(b, 'tsd'))
    
    if ~compatible_ts(a, b, eps)
        error('Timestamps mismatch')
    end
    
    if length(a.timeInterval.start) ~= length(b.timeInterval.start) || ...
            all(a.timeInterval.start ~= b.timeInterval.start) || ...
            all(a.timeInterval.stop  ~= b.timeInterval.stop)
        warning('timeIntervals of TSDs do not match - using first timeInterval');
    end
    
    s = tsd(a.t, a.data ./ b.data, 'timeInterval', a.timeInterval);
    
    
elseif (isa(a, 'tsd') && isa(b, 'numeric'))
    if(numel(b)) ~= 1
        error('./ operator defined for two tsd''s or for one tsd and one scalar');
    end
    
    s = tsd(a.t, a.data ./ b, 'timeInterval', a.timeInterval);
    
elseif (isa(a, 'numeric') && isa(b, 'tsd'))
    if(numel(b)) ~= 1
        error('./ operator defined for two tsd''s or for one tsd and one scalar');
    end
    
    s = tsd(b.t, a ./ b.data, 'timeInterval', b.timeInterval);
    
else
    error('./ operator defined for two tsd''s or for one tsd and one scalar');
end