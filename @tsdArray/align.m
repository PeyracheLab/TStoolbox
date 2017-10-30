function S1 = align(tsa, tsb, align_type)

%  aligns a tsdArray (tsa) to timestamps (tsb)
%  
%  USAGE:
%  tsO = tsa.align(tsb, 'closest');
%  
%  INPUTS:
%  tsa - a tsdArray
%  tsb - a set of timestamps
%
%  align_type: one of the four options
%  'prev': returns the points that immediately preceded each of the
%  timestamps
%  'next': returns the points that immediately followed each of the
%  timestamps
%  'closest': returns the points that best approximated the timestamps
%  'equal': returns the points that had the same time as the
%  timestamps. If perfect alignment cannot be achieved for all the points,
%  it returns an error.

%  copyright (c) 2009 Adrien Peyrache adrien.peyrache@gmail.com
%  rewritten, Luke Sjulson, 2017

if nargin<3
    align_type = 'closest';
end


S1={};

for i=1:length(tsa)
	
	Sr = tsa.C{i};
	S1 = [S1;{Sr.align(tsb, align_type)}];

end

S1 = tsdArray(S1);
	