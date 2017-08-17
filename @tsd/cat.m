function tsdOUT = cat(varargin)

% Vertical concatenation of TSD objects
%
%  	USAGE:
%  	tsdOUT = tsd/cat(tsd1, tsd2, ..., tsdn, ['shift', shiftVal]);
%
%  	INPUTS:
%       tsd1, tsd2, ... tsdn -- each one is a tsd
%       the option shift may be specified, in that case, the shiftVal(i)
%       value is added to all the timestamps in the i-th tsd, prior to
%       merging
%
%  OUTPUTS:
%  tsdOUT -- a tsd (not ctsd) that is a concatenation of all the inputs.
%
% ADR 1998
% version L4.1
% status: PROMOTED
% v4.1 17 nov 98 fullifies data to correctly handle sparse matrices
%
% changed Francesco P. Battaglia 2004 to implement units checks, and to
% introduce shift mechanism
%
% v2.0 Luke Sjulson, Aug 2017. Removed units, added intervalSets in TSDs.


shift = [];

if ~isa(varargin{1}, 'tsd')
    error(['Initial tsd is not of type "tsd".']);
end

tsdOUT = tsd(Range(varargin{1}), full(Data(varargin{1})), 'timeInterval', varargin{1}.timeInterval);

% implementing manual shift
if(isa(varargin{end-1}, 'char'))
    if strcmpi(varargin{end-1}, 'shift')
        shift = varargin{end};
        %    shift = Range(shift, tsdOUT.time_unit);
        tsdOUT = tsd(Range(tsdOUT)+shift(1), Data(tsdOUT), 'timeInterval', varargin{1}.timeInterval.shift(shift(1)));
        varargin = varargin(1:end-2);
    else
        error('Unrecognized option');
    end
end

tempT = tsdOUT.t;
tempD = tsdOUT.data;
tempIS = tsdOUT.timeInterval;


for iTSD = 2:length(varargin)
    % First, all inputs must be tsd or ctsd
    if ~isa(varargin{iTSD}, 'tsd')
        error(['Input ', num2str(iTSD), 'is not a "tsd"']);
    end
    
    % then all Data must be same dimension in non-time D
    szOUT = size(Data(tsdOUT));
    szTSD = size(Data(varargin{iTSD}));
    if szOUT(2:length(szOUT)) ~= szTSD(2:length(szTSD))
        error(['Data size mismatch: input ', num2str(iTSD), '.']);
    end
    
    % shift time indices and associated intervalSet
    t1 = Range(varargin{iTSD});
    iSet = varargin{iTSD}.timeInterval;
    if ~isempty(shift)
        t1 = t1 + shift(iTSD);
        iSet = iSet.shift(shift(iTSD));
    end
    
    % check to make sure times ok
    if ~isempty(t1) && ~isempty(Data(tsdOUT))
        if t1(1) < EndTime(tsdOUT)
            error(['Time mismatch: input ', num2str(iTSD), ' starts before previous data ends.']);
        end
    end
    
    tempT = [tempT; t1];
    tempD = [tempD; full(Data(varargin{iTSD}))];
    tempIS = cat(tsdOUT.timeInterval, iSet);
    
    %     tsdOUT.t = cat(1,tsdOUT.t, t1);
    %     tsdOUT.data = cat(1,tsdOUT.data, full(Data(varargin{iTSD})));
    %     tsdOUT.timeInterval = cat(tsdOUT.timeInterval, iSet);
    
end

tsdOUT = tsd(tempT, tempD, 'timeInterval', tempIS);



if isa(varargin{1}, 'ts') % if input was ts, return a ts too
    tsdOUT = ts(tempT, 'timeInterval', tempIS);
end
