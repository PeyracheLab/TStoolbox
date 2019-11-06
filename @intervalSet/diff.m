function O = diff(varargin)

%  Computes the set difference of intervalSet's
%
%  	USAGE:
%  	O = diff(O1, O2)
%
%  	INPUTS:
%  	O1, O2 - intervalSet objects
%
%  	OUTPUTS:
%  	O - intervalSet object corresponding to O1 - O2

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html


if nargin ~= 2
    error('Call with two arguments');
end

for i = 1:nargin
    if ~isa(varargin{i}, 'intervalSet')
        error('Arguments must be intervalSet');
    end
end


nbError = 0;

for i =1:nargin
    
    if length(Start(varargin{i})) > 0
        vararginN{i-nbError} = varargin{i};
    else
        nbError = nbError+1;
    end
    
end


if nargin-nbError>1
    
    
    
    do_string = '[start, stop] = do_diff(';
    for i = 1:nargin
        do_string = [do_string 'Start(varargin{' num2str(i) ...
            '}, ''ts''), End(varargin{' num2str(i) '}, ''ts''), ' ...
            ];
    end
    
    do_string = [do_string(1:(end-2)) ' );'];
    
    eval(do_string);
    
    if any(diff(stop)<=0) || any(diff(start)<=0)
        warning('timestamps are not sorted')
        start(find(diff(stop)<=0)+1)=[];
        stop(find(diff(stop)<=0)+1)=[];
        stop(find(diff(start)<=0)+1)=[];
        start(find(diff(start)<=0)+1)=[];
        
    end
    O = intervalSet(start, stop);
    
else
    
    O = varargin{1};
    
end



