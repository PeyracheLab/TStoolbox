function [R, ix] = Restrict(tsa, timeInterval)

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
% released under the GPL
%
% rewritten by Luke Sjulson, 2017. Removed functionality by which one TSD
% can be restricted against another TSD.

timeInterval = timeInterval.intersect(tsa.timeInterval);
if isempty(timeInterval.start)
    warning('intervalSets do not overlap - returning empty TSD');
    R = tsd();
    ix = [];
else
    
    ix = Restrict_idx_iSet(double(tsa.t), double(timeInterval.start), double(timeInterval.stop));
    % doing this so that time points exactly equal to the start/stop boundaries are
    % not removed
    startIx = [];
    stopIx = [];
    for idx = 1:length(timeInterval.start)
        startIx = [startIx; find(tsa.t==timeInterval.start(idx))];
        stopIx = [stopIx; find(tsa.t==timeInterval.stop(idx))];
    end
    ix = sort(unique([startIx; ix(:); stopIx]));
    tt = tsa.t(ix);
    
    
    % timeInterval in the new TSD is the intersection of the olt timeInterval
    % with the new timeInterval
    if isa(tsa, 'ts')
        R = ts(tt, 'timeInterval', timeInterval.intersect(tsa.timeInterval));
    else
        R = tsd(tt, SelectAlongFirstDimension(tsa.data, ix), 'timeInterval', timeInterval.intersect(tsa.timeInterval));
    end
end