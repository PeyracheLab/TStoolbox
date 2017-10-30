function A = shift(tsa, shift, whichidx)

% this method shifts spike times of the various elements in the tsdArray
%
% Usage:
% X = tsa.shift(5);             % shifts all spikes by 5 seconds (e.g. from 1 to 6)
% X = tsa.shift(5, [1 3 5]);    % shifts all spikes in elements 1, 3, 5 by 5 seconds

% allowing indexing of certain elements of the tsdArray
if length(tsa) ~= numel(tsa)
    error('shift method only works for 1-D tsdArrays');
end

if nargin<3
    whichidx = true(length(tsa.C), 1);
end
if ~islogical(whichidx)
    whichnum = whichidx;
    whichidx = false(length(tsa.C), 1);
    whichidx(whichnum) = true;
end

newC = cell(size(tsa));

% shifting them in time
for idx = 1:numel(tsa.C)
    if whichidx(idx) == true
        newC{idx} = tsa.C{idx}.shift(shift);
    end
end

A = tsdArray(newC);


