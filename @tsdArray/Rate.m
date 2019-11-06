function r = rate(S0, varargin)

%  Returns a vector containing the firing rate of each TS in the tsdArray.
%  The intervalSet argument is optional - if omitted, it will use the
%  timeInterval stored in each TSD. If provided, firing rate will be
%  calculated over the intersection of the intervalSet with the TSD's
%  timeInterval.
%
%  	USAGE:
%  	eno = Start(tsa,is)
%
%  	INPUTS:
%  	tsa - a tsdArray
%  	is - an intervalSet
%
%  	OUTPUT:
%  	r - rate vector
%
%  copyright (c) 2009 Adrien Peyrache adrien.peyrache@gmail.com
%
%  v2.0, Luke Sjulson, Aug 2017


r = zeros(length(S0),1);

if nargin>1 % using externally applied intervalSet
    for c=1:length(S0)
        r(c) = rate(S0.C{c}, varargin{1});        
    end
    
else        % using intervalSet stored in each TSD
    for c=1:length(S0)
        tempC = S0.C{c};
        r(c) = rate(tempC);
    end
end
