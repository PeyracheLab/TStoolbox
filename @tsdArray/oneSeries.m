function TSO = oneSeries(S)

% Sorts all the spike times in each element in the tsdArray, and returns a 
% single TS with all the spike times. TS.timeInterval is the union of all
% timeIntervals in the tsdArray.
%  
%  	USAGE:
%  	tso = oneSeries(tsa) 

N = S.numel;

spikeTimes = [];
iSet = S.C{1}.timeInterval;

for idx = 1:N
    spikeTimes = [spikeTimes; S.C{idx}.t(:)];
    iSet = iSet + S.C{idx}.timeInterval; % union of all intervalSets
end

TSO = ts(sort(spikeTimes), 'timeInterval', iSet);

  
      