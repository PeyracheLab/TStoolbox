function R = Range(tsa, tsflag)

% Returns TSD timestamps
% 
%  USAGE:
%  R = Range(tsa)
%  R = Range(tsa, tsflag)
%  
%  OPTIONS:
%  tsflag - if 'ts' returns time in timestamps (default),
%  	    if 'sec' returns time in sec
%  	    if 'ms' returns time in ms


% ADR 
% version L4.1
% status: PROMOTED

% v4.1 28 oct 1998 flag no longer optional.
%   if nargin == 2
%     if isa(tsflag, 'units')
%       ;
%       
%     elseif isa(tsflag, 'char')
%       tsflag = time_units(tsflag);
%     else
%       error('tsflag must be time_units, or string');
%     end
%     
%   else 
%     tsflag = tsa.time_unit; %defaults to ts
%   end
%     
%   cnvrt = convert(tsa.time_unit, tsflag);
%   
%   if cnvrt ~= 1
%     R = tsa.t * cnvrt;
%   else
%     R = tsa.t;
%   end

if nargin<2
    tsflag = 's';
end

if strcmpi(tsflag, 's') || strcmpi(tsflag, 'sec')
    R = tsa.t;
elseif strcmpi(tsflag, 'ms') || strcmpi(tsflag, 'msec')
    R = tsa.t .* 1000;
elseif strcmpi(tsflag, 'm') || strcmpi(tsflag, 'min')
    R = tsa.t ./ 60;
elseif strcmpi(tsflag, 'h') || strcmpi(tsflag, 'hr')
    R = tsa.t ./ (60*60);
else 
    error('unit flag not recognized');
end



  