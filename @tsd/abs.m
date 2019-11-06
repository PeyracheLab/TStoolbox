function a = abs(tsa)
% Absolute value of the data
%  
%  USAGE:
%  tso = abs(tsa)
%  
%  INPUT:
%  tsa: a tsd object
%  
%  OUTPUT:
%  tso: a tsd of absolute value
% 
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson Aug 2017 - removed units support, added intervalSet

  a = tsd(tsa.t, abs(tsa.data), 'timeInterval', tsa.timeInterval);