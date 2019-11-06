function in = inInterval(O, tsa, varargin)

%  Tells whether points are contained in intervalSet (TODO)
%
%  TODO: overlap with the belong function?
%
%
% in = inInterval(O, tsa, OptionName, OptionValue, ...)
%
% the data of the returned timestamp count the number of intervals in the
% intervalSet containing the points in the tsd
% INPUTS
% O: an intervalSet object
% tsa: a tsd object
% OUTPUTS
% in: tsd with the interval count
% OPTIONS:
% 'count': if set to 'binary' (default) count is only zero or 1, if set to 'number'
% returns the number of intervals containing the point

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html



opt_varargin = varargin;
defined_options = dictArray({ { 'count', {'binary', {'char'} } } } );

getOpt;

switch count
    case 'binary'
        doBinary = 1;
    case 'number'
        doBinary = 0;
    otherwise
        error('Unrecognized value for option count');
end

ix = inIntervalSet_c(Range(tsa), Start(O), End(O));

if doBinary
%     in = tsd(Range(tsa), (ix > 0), 'timeInterval', O);
    in = tsd(Range(tsa), (ix > 0), 'timeInterval', tsa.timeInterval);
else
%     in = tsd(Range(tsa), ix, 'timeInterval', O);
    in = tsd(Range(tsa), ix, 'timeInterval', tsa.timeInterval);
    
end

warning('The TSD created by inInterval() internally has the intervalSet of the TSD, not the intervalSet that has inInterval() as a method');

