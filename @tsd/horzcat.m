function s = horzcat(a, b, varargin)

%  Horizontal concatenation of TSDs (overload of the [a, b] operator)
%
%  	USAGE:
%  	tso = horzcat(tsa, tsb, ...)
%
%  	arguments must be all tsd, the cat function is used. TSDs must have the
%  	same time points in order for data to be concatenated.
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. 


if ~compatible_ts(a, b)
    error('timestamps mismatch');
end

if length(a.timeInterval.start) ~= length(b.timeInterval.start) || ...
        all(a.timeInterval.start ~= b.timeInterval.start) || ...
        all(a.timeInterval.stop  ~= b.timeInterval.stop)
    warning('timeIntervals of TSDs do not match - using first timeInterval');
end



if ~isempty(varargin)
    for i = 1:length(varargin)
        if ~isa(varargin{i}, 'tsd')
            error('all arguments must be tsd''s');
        end
        if ~compatible_ts(a, varargin{i})
            error('timestamps mismatch');
        end
    end
end


d = cat(2, a.data, b.data);

if ~isempty(varargin)
    for i = 1:length(varargin)
        dv = varargin{i};
        dv = dv.data;
        d = cat(2, d, dv );
    end
end


s = tsd(a.t, d, 'timeInterval', a.timeInterval);
