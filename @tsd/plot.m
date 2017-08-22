function p = plot(tsd)

%  Plots data in a TSD using time as x and data as y.  If time = data (ie
%  for spikes data), plotting is done as a series of points.
%  	
%  	USAGE:
%  	plot(tsd) 
%  	
%  	INPUTS:
%  	tsd - a tsd object
%  	
%  	OUTPUTS:
%  	p   - the plot handle
%
% copyright (c) 2014 Brendon O. Watson


x = Range(tsd);
y = Data(tsd);
if sum(x-y) == 0
    y = zeros(size(x));
    p = plot(x,y,'.');
else
    p = plot(x,y);
end
