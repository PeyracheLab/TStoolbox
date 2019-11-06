function [tso, ix] = RestrictThreshold(tsa, thr, varargin)

%  Restricts TSD to values above (below) threshold
%  
%  	USAGE:
%  	[tso, ix] = Restrict_threshold(tsa, thr, varargin) 
%  	
%  	INPUTS: 
%  	tsa - a tsd object
%  	thr - a threshold value 
%  	
%  	OUTPUTS:
%  	tso - the restricted tsd
%  	ix (optional) - the indices of the restricted tsd within tsa
%  	
%  	OPTIONS:
%  	'Direction' - possible values are 'Above' (default) 'Below'
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0 Luke Sjulson Aug 2017


 opt_varargin = varargin;
 
 defined_options = dictArray({ { 'Direction', {'Above', { 'char' } } } ...
		   });
 
 getOpt;
 
 is = thresholdIntervals(tsa, thr, 'Direction', Direction);
 
 [tso, il] = Restrict(tsa, is);
 
 if nargout == 2
   ix = il;
 end
   
  
  