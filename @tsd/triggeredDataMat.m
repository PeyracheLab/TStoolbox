function M = triggeredDataMat(tsa, t, nbBins,varargin)

%  Returns a event-by-events matrix of Data component triggered on a reference (TODO!)
%
%  	USAGE:
%  	M = triggeredDataMat(tsa,evt,nbB)
%
%  	INPUTS:
%  	tsa - a tsd
%  	evt -  time of triggers
%  	nbB - nb of timestamps before and after (i.e. a total of 2*N+1 bins)
%
%  	OUTPUT:
%  	M - a matrix length(T) x (2*N+1) of event-by-events Data cmponent
%
%  TODO: debug & rewrite this really bad code


% copyright (c) 2009 Adrien Peyrache adrien.peyrache@gmail.com
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

warning('triggeredDataMat is not production-ready');

d = Data(tsa);
rg = Range(tsa);
rgR = Range(Restrict(tsa,t));
ix = find(ismember(rg,rgR));
M = [];

lmax = length(d);
i=1;

while i<=length(ix) && (ix(i)+nbBins<lmax)
    if (ix(i)-nbBins>1)
        M = [M;d(ix(i)-nbBins:ix(i)+nbBins)'];
    end
    i = i+1;
end