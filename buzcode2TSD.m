function tsa = buzcode2TSD(spikeTimes, intervals)

% function tsa = buzcode2TSD(spikeTimes, intervals)
%
% This function takes as inputs buzcode-compatible spike time and interval
% matrices, then generates a TStoolbox2-compatible ts object or tsdArray.
%
% INPUTS
% spikeTimes - either a vector of times (one cell) or a cell array of
%              vectors of spike times (multiple cells)
% intervals (optional) - intervals over which the spike trains are defined.
%              The format is in a two-column matrix of [starts stops].
%
% OUTPUTS
% tsa        - either a ts object or tsdArray of ts objects storing the
%              spikeTimes. If intervals is not specified, the default
%              interval is from the first spike to last spike.
%

% v2.0, Luke Sjulson, Aug 2017


if ~iscell(spikeTimes) % single spike train, make ts object
   if nargin==1
      tsa = ts(spikeTimes);
   elseif nargin==2
      tsa = ts(spikeTimes, 'timeInterval', intervalSet(intervals(:,1), intervals(:,2)));
   else error('wrong number of arguments');
   end
   
elseif iscell(spikeTimes) % cell array of spike trains, make tsdArray
   S = {};
   if nargin==1
      for idx = 1:length(spikeTimes)
         S{idx} = ts(spikeTimes{idx});
      end
   elseif nargin==2
      for idx = 1:length(spikeTimes)
         S{idx} = ts(spikeTimes{idx}, 'timeInterval', intervalSet(intervals(:,1), intervals(:,2)));
      end
   else error('wrong number of arguments');
   end
   
   tsa = tsdArray(S);
   
   
end