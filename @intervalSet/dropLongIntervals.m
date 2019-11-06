function iso = dropLongIntervals(is, thr, varargin)

%  Drops the intervals in the set that are longer than a given threshold
%  
%  	USAGE:
%  	iso = dropLongIntervals(is, thr, OptionName, OptionValue) 
%  	
%  	INPUTS:
%  	is  - an intervalSet
%  	thr - a duration threshold; all intervals longer than thr will be
%  	dropped
%  	
%  	OUTPUTS:
%  	iso - the resulting intervalSet


% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
  
  
  
%   opt_varargin = varargin;
%   
%   defined_options = dictArray( ...
%   { { 'TimeUnits', {time_units('ts'), {'char', 'units'} } } } );
%   
%   getOpt;  
%   
%   
%   cnvrt = convert(TimeUnits, is.units);
%   
%   thr = thr * cnvrt;
  
  st = Start(is);
  en = End(is);
  
  d = en-st;
  
  ix = find(d < thr);
  
  iso = intervalSet(st(ix), en(ix));
  
  
  
  