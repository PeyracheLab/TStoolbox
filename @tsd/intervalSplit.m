function S = intervalSplit(tsa, is, varargin)

%  Returns a cell array of tsd object, one for each subset of a given
%  interval. Output corresponds to intersection of input intervalSet with
%  internal TSD intervalSet.
%  
%  	USAGE:
%  	S = intervalSplit(tsa, is, optionName1, optionValue1, ...) 
%  	
%  	INPUTS:
%  	tsa - a tsd object
%  	is  - an intervalSet objetct
%  	
%  	OUTPUTS:
%  	S   - a cell array of tsd object one for each array 
%  
%  	OPTIONS:
%  	'OffsetStart' - realigns timestamps so that beginning of interval
%  			corresponds to OptionValue
%  	'OffsetEnd'   - realigns timestamps so that end of interval
%  			corresponds to OptionValue
%  	no realignment by default.
%  
%  copyright (c) 2004 Francesco P. Battaglia
%  small debugging by A Peyrache, 2007
%  This software is released under the GNU GPL
%  www.gnu.org/copyleft/gpl.html
%
% v2.0, Luke Sjulson, Aug 2017. Removed units, added intervalSet in TSD.
  
  defined_options = dictArray({ 
      { 'OffsetStart', {NaN, {'numeric'} } }, 
      { 'OffsetEnd', {NaN, {'numeric'} } },
		   } );
  
  opt_varargin = varargin;
  
  getOpt;
  is = is.intersect(tsa.timeInterval);
  
  
  if isfinite(OffsetStart) & isfinite(OffsetEnd)
      error('Cannot specify both OffsetStart and OffsetEnd');
  end

  S = {};

  if ~isempty(Start(is))
      [S_start, S_end] = intervalSplit_c(Range(tsa), Start(is), ...
          End(is));

      realign = zeros(size(Start(is)));

      if isfinite(OffsetStart)
          realign = OffsetStart - Start(is);
      elseif isfinite(OffsetEnd)
          realign = OffsetEnd - End(is, tsa);
      end



      for i = 1:length(S_start)
          if S_end(i)-S_start(i) > 0
              s = subset(tsa, (S_start(i)):(S_end(i)));
              s = tsd(s.t+realign(i), s.data, 'timeInterval', intervalSet(S_start(i), S_end(i)));
          else
              s = tsd([], []);
          end

          S = [S;{s}];

      end
  end
  S = tsdArray(S);

    
