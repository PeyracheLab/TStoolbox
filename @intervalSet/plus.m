function s = plus(a, b)

%  Union of two intervalSet's (overload of the + operator)
%
%  	USAGE
%  	s = a + b;
%
% Luke Sjulson, Aug 2017

s = union(a, b);

