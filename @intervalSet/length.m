function L = length(O, varargin)

%  Returns the length of each interval in the set
%
%  	USAGE:
%  	L = length(O, TimeUnits)
%
%  	INPUTS:
%  	O: an intervalSet object
%  	TimeUnits: a units object or the abbreviation string
%
%  	OUTPUT:
%  	L - a tsd object , where the timestamps correspond to each interval (see
%  	OPTIONS for possibilities) and the data gives the length of each interval
%
%  	OPTIONS:
%  	'time' - determines which time is selected for each interval, possible
%  		values are
%  		'start' (default) - use start of intervals
%  		'end' - use end of intervals
%  		'middle' - use middle point of intervals
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html





opt_varargin = varargin;

time_opt_values = dictArray({ { 'start', []},
    { 'end', []},
    { 'middle', []} });
defined_options = dictArray({ { 'time', {'start', {'char'} } } } );

getOpt;
l = End(O) - Start(O);
% l = O.stop - O.start;

switch time
    case 'start'
        t_ic = Start(O);
    case 'end'
        t_ic = End(O);
    case 'middle'
        t_ic = ( Start(O) + End(O) ) / 2;
end

L = tsd(t_ic, l, 'timeInterval', O);

