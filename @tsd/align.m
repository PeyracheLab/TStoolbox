function [R, ix] = align(tsa, tsb, align_type)

%  Align a TSD to timestamps (tsd or array of times)
%
%  USAGE:
%  R = tsa.align(tsb, align_type)
%
%  The option align_type specifies the type of approximation to
%  produce. possible values are
%  'prev': returns the points that immediately preceded each of the
%  timestamps
%  'next': returns the points that immediately followed each of the
%  timestamps
%  'closest': returns the points that best approximated the timestamps
%  'equal': returns the points that had the same time as the
%  timestamps. If perfect alignment cannot be achieved for all the points,
%  it returns an error.
%

% Luke Sjulson, 2017-10-27
% based on code from Francesco Battaglia and A. David Redish

if nargin<3
    align_type = 'closest';
end

if isa(tsb, 'ts') || isa(tsb, 'tsd')
    
    st = Range(tsb);
    
    if (~isempty(st)) && length(tsa) > 0
        ix = Restrict_idx_align(Range(tsa), st, align_type);
    else
        ix = [];
    end
    
    if isa(tsa, 'ts')
        R = ts(st);
    else
        R = tsd(st, SelectAlongFirstDimension(tsa.data, ix));
    end
    
else
    error('the timestamp argument to align() must be a ts or tsd');
end