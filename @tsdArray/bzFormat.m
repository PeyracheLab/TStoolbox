function [timeArray, dataArray, intervals] = bzFormat(tsa, iSetType)

% function [timeArray, dataArray, intervals] = bzFormat(tsa, iSetType)
% 
% bzFormat converts a tsdArray to the buzcode format.
%
% INPUTS
% tsa - the name of the tsdArray
% iSetType (optional) - can be either 'union' (default) or 'intersection'
%
% OUTPUTS
% timeArray   - a cell array of vectors of timestamps (e.g. spike times)
% dataArray   - a cell array of data matrices (empty for spike trains)
% intervals   - the intervals over which the tsdArray is defined. This
%               can be either the union or intersection of all of the 
%               individual intervalSets in each element of the tsdArray,
%               and the format is in a two-column matrix of [starts stops]
%
% USAGE 
% [a, b, c] = bzFormat(tsa);
%
% - note that tsa.bzFormat syntax does not work


%
% Luke Sjulson, Aug 2017

if nargin<2
   iSetType = 'union';
end

timeArray = {};
dataArray = {};

for idx = 1:tsa.length
   tempTSD = tsa.C{idx};
   timeArray{idx} = tempTSD.t;
   dataArray{idx} = tempTSD.data;
end

IS = tsa.timeInterval(iSetType);
intervals = IS.array;
   
timeArray = timeArray';
dataArray = dataArray';



