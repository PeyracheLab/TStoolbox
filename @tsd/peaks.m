function p = peaks(tsa, varargin)

%  Get peaks in data
%
%  	USAGE:
%  	p = peaks(tsa, OptionName, OptionValue, ...)
%
%  	INPUTS:
%  	tsa - a tsd object
%
%  	OUTPUTS:
%  	p   - a tsd containing the peaks of tsa
%
%  	OPTIONS:
%  	'Extremes' - the kind of peaks:
%  	'MaxMin'   - both max and mins are returned (default)
%  	'Rectify'  - same but returning absolute value
%  	'Max'      - only peaks are returned
%  	'Min'      - only troughs are returned
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Added intervalSet in TSD.

opt_varargin = varargin;

defined_options = dictArray({ { 'Extremes', {'MaxMin', {'char'} } } } );

getOpt;

d = Data(tsa);
if isempty(d)
    error('peaks not defined for tsd with empty data!');
end

if size(d, 2) > 1
    error('peaks only defined for tsd with column vector data');
end

t = Range(tsa);

dd = diff(d);
dd1 = dd(1:(end-1));
dd2 = dd(2:end);



switch Extremes
    case {'MaxMin', 'Rectify'}
        ix = find((dd1 > 0 & dd2 < 0) | (dd1 < 0 & dd2 > 0)) + 1;
    case 'Max'
        ix = find((dd1 > 0 & dd2 < 0)) + 1;
    case 'Min'
        ix = find((dd1 < 0 & dd2 > 0)) + 1;
    otherwise
        error('Unrecognized option value');
end


d = d(ix);
t = t(ix);

if strcmp(Extremes, 'Rectify');
    d = abs(d);
end

p = tsd(t, d, 'timeInterval', tsa.timeInterval);




