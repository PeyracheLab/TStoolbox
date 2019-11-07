function is = timeSpan(S, type)

%  Returns interval spanning the entire duration of the tsdArray. It uses the
%  intervalSets stored inside each TSD, and based on the union (default) or 
%  intersection of those, it calculates a single interval that goes from
%  the first start to the last end, with no gaps inbetween.
%  	
%  	USAGE:
%  	is = tsa.timeSpan(type)
%  	
%   INPUTS:
%   type (optional) - 'union' (default) or 'intersection'
%
%  	OUTPUT:
%  	is - an intervalSet object
%  
%  v2.0 rewritten by Luke Sjulson, Aug 2017
%  modified by Adrien Peyrache, Nov 2019


if nargin<2
    type = 'union';
end

% calculate union/intersection of whole tsdArray
st = Inf;
en = -Inf;

for ii=1:length(S)
    s  = S.C{ii};
%    iSet = s.timeInterval(type);
    iSet = s.timeInterval;
    iSetSt = Start(iSet);
    iSetEn = End(iSet);
    st = min(st,iSetSt(1));
    en = max(en,iSetEn(end));
end

is = intervalSet(st,en);