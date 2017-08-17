function S = smooth(tsa, l, varargin)

%  Smooth a TSD
%
%  	USAGE:
%  	S = smooth(tsa, l, OptionName, OptionValue, ...)
%  	%
%  	This is intended for continuously sampled tsd-s, the sampling rate is
%  	guessed with the median inter-event interval method (see MEDIAN_DT)
%  	If there are some missing values, they are interpolated before
%  	smoothing. If the TSD contains a matrix of data, each column will be
%  	smoothed separately.
%
%  	INPUTS:
%  	tsa - a tsd object
%  	l   - the length of the smoothing window
%
%  	OUTPUTS:
%  	S - the smoothed tsd
%
%  	OPTIONS:
%  	'UseWindow' - type of window to use for smoothing, defaults to
%  		hamming. Admissible   values are 'bartlett', 'blackman', 'boxcar',
%  		'chebwin', 'hamming', 'hann', 'kaiser'
%  		'InIntervals', if non-empty, must be a cell array of intervalSet.
%  		In that case, the tsd is taken to be non-contiguous,
%  		and to only assume values in the specified set of IntervalSets
% 
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added support for intervalSets in TSDs and
% smoothing for multidimensional TSDs.


opt_varargin = varargin;
defined_options = dictArray( ...
    { { 'UseWindow', {'hamming', {'char'} } },  ...
    {'InIntervals', { {}, {'cell'} } } } );

getOpt;

if ~isempty(InIntervals)
    for i = 1:length(InIntervals)
        tsdR{i} = Restrict(tsa, InIntervals{i});
        tsdR{i} = smooth(tsdR{i}, l, 'UseWindow', UseWindow);
    end
    S = cat(tsdR{:});
    return
end

l = l / median_dt(tsa);

l = floor(l/2) * 2;

eval(['hh = ' UseWindow '(l, ''symmetric'');']);

tsi = interp_missing(tsa);

v = Data(tsi);

t = Range(tsi);

for idx = 1:size(v, 2)
    v2(:, idx) = conv(v(:, idx), hh);
end

v = v2(l/2:end-l/2, :);

v = v / sum(hh);

S = tsd(t, v, 'timeInterval', tsa.timeInterval);
