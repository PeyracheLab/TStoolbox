% Constructor of TSD object
%
%  	USAGE:
%  	tsa = tsd(t,data, 'optionName1', optionValue1,... )
%
%  tsd is a class of "timestamped arrays"
%  composed of an array of timestamp (column vector), and an array of data
%  associated to each timestamp (first index corresponding to time).
%  data maybe empty, for 0-dimensional data (for example ts
%  data). Othewise first dimension must be same as length of timestamp
%  vector
%  timestamps are assumed to be sorted. If this is not the case, the
%  constructor fails, unless the fixOrder option is set
%  options may include the following:
%
%  'fixOrder'	- if set to nonzero, constructor will reorder the timestamps,
%  		  in the case they are not sorted.
%
% ADR
% version L4.0
% status: PROMOTED
%
% version by Francesco P. Battaglia 2004
%
% version 2.0 by Luke Sjulson 2017 - stripped out unit checking and
% included intervalSet in TSD


classdef tsd
    properties (SetAccess = immutable)
        version
        t
        t_info
        data
        data_info
        timeInterval
        timeInterval_info
    end
    properties
        name
    end
    methods
        function tsa = tsd(t, data, varargin)
            tsa.version = 2.0;
            
            if nargin == 0
                tsa.t = NaN;
                tsa.data = NaN;
                tsa.name = '';
                tsa.timeInterval = intervalSet;
                return
            end
            
            if nargin < 2
                error('tsd constructor must be called with t, data');
            end
            
            % default option values
            fixOrder = 0;
            
            if ~isempty(varargin)
                defined_options = ...
                    dictArray({ { 'fixOrder', { 0, { 'numeric' } } },
                    { 'keepUnordered', { 0, { 'numeric' } } },
                    { 'Name', { '', { 'char' } } },
                    { 'timeInterval', {[], { 'intervalSet' } } } });
                
                opt_varargin = varargin;
                getOpt;
                if isempty(timeInterval)
                    timeInterval = intervalSet(min(t), max(t));
                end
            else
                fixOrder = 0;
                keepUnordered = 0;
                Name = '';
                timeInterval = intervalSet(min(t), max(t));
            end
            
            if isempty(t)
                t = zeros(0,1);
            end
            
            
            if all(size(t) ~= 1)
                error('t must b row or column error');
            end
            
            if size(data, 1) ~= length(t) & (~isempty(data))
                error('data must be N x X x Y x ..., where N is length(t), or empty');
            end
            
            
            t = t(:);
            
            if any(diff(t) < 0)
                if fixOrder
                    [t, ix] = sort(t);
                    data = SelectAlongFirstDimension(data, ix);
                elseif ~keepUnordered
                    error('timestamps are not sorted!');
                end
            end
            
            ix = Restrict_idx_iSet(double(t), timeInterval.start, timeInterval.stop); % if any of these are ints, it seg faults
            
            % doing this so that time points exactly equal to the start/stop boundaries are
            % not removed
            startIx = [];
            stopIx = [];
            for idx = 1:length(timeInterval.start)
                startIx = [startIx; find(t==timeInterval.start(idx))];
                stopIx = [stopIx; find(t==timeInterval.stop(idx))];
            end
            ix = sort(unique([startIx; ix(:); stopIx]));
            tsa.t = t(ix);
            
            
            tsa.name = Name;
            tsa.timeInterval = timeInterval;
            
            
            if strcmpi(tsa.name, 'spike train')
                tsa.t_info = 'spike times';
                tsa.timeInterval_info = 'intervalSet over which spike times are defined';
            else
                % restrict time points to those within the intervalSet
                if ~isempty(data)
                    tsa.data = data(ix,:);
                    tsa.data_info = 'values at time points';
                else
                    tsa.data = [];
                    tsa.data_info = 'empty dataset';
                end

                tsa.t_info = 'time points';
                tsa.timeInterval_info = 'intervalSet over which data is defined';
            end
            %      tsa = Restrict(tsa, timeInterval);
            
            
        end
    end
end



