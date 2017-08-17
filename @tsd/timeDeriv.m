function S = timeDeriv(tsa, varargin)

%  TimeDerivative of a tsd
%
%  	USAGE:
%  	S = timeDeriv(tsa, OptionName, OptionValue, ...)
%
%  	This is intended for continuously sampled tsd-s,
%  	If there are some missing values, they are interpolated before smoothing
%
%  	INPUTS:
%  	tsa - a tsd object
%
%  	OUTPUTS:
%  	S - the derivative tsd
%
%  	OPTIONS:
%  	'PreSmooth', if set the tsd will be smoothed by that amount

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added support for multidimensional arrays and
% intervalSets in TSD.

opt_varargin = varargin;
defined_options = dictArray( ...
    { { 'PreSmooth', {0, {'numeric'} } } ,
    {'InIntervals', { {}, {'cell'} } } } );
getOpt;
if ~isempty(InIntervals)
    for i = 1:length(InIntervals)
        tsdR{i} = Restrict(tsa, InIntervals{i});
        tsdR{i} = timeDeriv(tsdR{i}, 'PreSmooth', PreSmooth);
    end
    S = cat(tsdR{:});
    return
end


if PreSmooth
    tsa = smooth(tsa, PreSmooth);
else
    tsa = interp_missing(tsa);
end


t = Range(tsa);

S = tsd(t(1:end-1), diff(Data(tsa), 1, 1) ./ repmat(diff(t), 1, size(tsa.data, 2)), 'timeInterval', tsa.timeInterval);

