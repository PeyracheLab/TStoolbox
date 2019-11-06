function [StO,ix] = Start(S0)

%  Returns a vector containing the time of the first event of each tsd
%  	
%  	USAGE:
%  	sto = Start(tsa,is)
%  	
%  	INPUTS:
%  	tsa - a tsdArray
%  	is - an intervalSet
%  	
%  	OUTPUT:
%  	sto - an vector of time
%	ix - index of tsds with at least one event

%  copyright (c) 2009 Adrien Peyrache adrien.peyrache@gmail.com


StO = [];
ix = [];
for i=1:length(S0)	
	Sr = S0.C{i};
	rg = Range(Sr);
	if length(rg)>0
		StO = [StO;rg(1)];
		ix = [ix;i];
	end
end
