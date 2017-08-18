function iSet = timeInterval(S, type)

%  Returns intervalSet that is either the union or intersection of all
%  timeInterval's in the tsdArray
%  	
%  	USAGE:
%  	iSet = timeInterval(S, type)
%
%   INPUTS:
%   S - tsdArray
%   type (optional) - can be 'union' (default) or 'intersection'
%
%   v2.0, Luke Sjulson, Aug 2017


if nargin<2 || isempty(type)
    type = 'union';
end

% calculate union of all intervalSets
if strcmpi(type, 'union')
    N = numel(S);
    iSet = S.C{1}.timeInterval;
    for idx = 1:N
        iSet = iSet + S.C{idx}.timeInterval;
    end
elseif strcmpi(type, 'intersection')
    N = numel(S);
    iSet = S.C{1}.timeInterval;
    for idx = 1:N
        iSet = iSet & S.C{idx}.timeInterval;
    end
else
    error('"type" must be either "union" or "intersection"');
end


    