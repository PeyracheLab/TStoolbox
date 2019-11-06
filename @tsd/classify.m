function [tout, N] = classify(tsa, is, col)

%  Breaks a TSD object in many tsds according to the value of data
%  	
%  	USAGE:
%  	[tout, N] = classify(tsa, is, col) 
%  	
%  	INPUTS:
%  	tsa - a tsd object, with at most two-dimensional data
%  	is  - an intervalSet containing the limits for the data: data falling in
%  	      the first interval will end up in the first tsd in the output tsdArray,
%  	      and so on
%  	col - which column in the data member to use for the classification 

% copyright (c) 2006 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

if nargin < 3
    col = 1;
end

if length(size(tsa.data)) > 2
    error('data must be at must 2-dimensional');
end

nIntervals = length(Start(is));
s = Start(is);
e = End(is);
d = tsa.data;
t = tsa.t;
dSort = d(:,col);

[dSort, ix] = sort(dSort);
d = d(ix,:);
t = t(ix);
tout = cell(0,1);

for i = 1:nIntervals
    ixStart = min(find(dSort > s(i)));
    ixEnd = max(find(dSort < e(i)));
    
    d1 = d((ixStart:ixEnd), :);
    t1 = t(ixStart:ixEnd);
    
    [t1, ix] = sort(t1);
    d1 = d1(ix,:);
    tout{i} = tsd(t1, d1);
    N(i) = length(t1);
end

tout = tsdArray(tout(:));
    