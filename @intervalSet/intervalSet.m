%  Constructor for intervalSet objects
%
%  	USAGE:
%  	O = intervalSet(s, e, fixit, PropertyName, PropertyValue, ....)
%
%  	INPUTS:
%  	if no inputs, return a null intervalSet object
%  	s, e - vectors containing start and stop times for intervals
%
%  	'PropertyName', PropertyValue: set properties
%
%  	once created objects are readonly, so properties can be set only in the
%  	constructor
%
%  	if the '-fixit' flag is specified as an argument, the start and stop
%  	arrays are fixed in such a way that the intervalSet is made out of the
%  	smallest intervals included between a start point and a stop point
%
% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html
%
% version 2.0 by Luke Sjulson, 2017 - main change is removal of unit
% checking

classdef intervalSet
   properties (SetAccess = immutable)
      %         units
      version
      start
      stop
   end
   properties % name field is mutable
      name
   end
   methods
      
      function O = intervalSet(varargin)
         O.version = 2.0;
         
         
         if nargin == 0
            %                 O.units = {};
            O.start = [];
            O.stop = [];
            %O = class(O, 'intervalSet');
            return
            
         end
         
         % making buzcode-compatible
         if nargin == 1 && size(varargin{1}, 2)==2 % if given a two-column matrix as a single argument
            O.start = double(varargin{1}(:,1))';
            O.stop = double(varargin{1}(:,2))';
            
            if any(O.start>O.stop)
               error('Stops can not come before their respective starts');
            end
            
            if any(O.start ~= sort(O.start)) 
               warning('starts are not sorted - sorting now...');
               [O.start, ix] = sort(O.start);
               O.stop = O.stop(ix);
               
            end
            
            tempMat = [O.start; O.stop];
            tempMat = tempMat(:); 
            if any(diff(tempMat)<0)
               warning('intervals are overlapping - check this is not an error');
            end
            
            
            
            return
         end
         
         if isa(varargin{1}, 'intervalSet')
            if(length(varargin) > 1)
               error('Trailing arguments in copy constructor');
            else
               O = varargin{1};
               return
            end
            %             else
            %                 O.units = {};
         end
         
         
         if(length(varargin) < 2)
            error('constructor either takes two arguments: (start, stop) or a single argument {[start stop])');
         end
         %   O.units = units('time', 'ts');
         
         s = varargin{1};
         if isa(s, 'numeric')
            ;
         elseif isa(s, 'tsd')
            %                 if ~isempty(O.units)
            %                     s = Range(s, O.units);
            %                 else
            s = Range(s);
            %                 end
         else
            error('arguments must be arrays and/or tsd');
         end
         
         
         
         e = varargin{2};
         if isa(e, 'numeric')
            ;
         elseif isa(e, 'tsd')
            %                 if ~isempty(O.units)
            %                     e = Range(e, O.units);
            %                 else
            e = Range(e);
            %                 end
         else
            error('arguments must be arrays and/or tsd');
         end
         
         c_varargin = varargin(3:end);
         
         %             input_units = [];%time_units('ts');
         fixit = 0;
         if nargin == 0
            s = zeros(0,1);
            e = zeros(0,1);
         end
         
         while ~isempty(c_varargin)
            
            switch(char(c_varargin(1)))
               case '-fixit'
                  fixit = 1;
                  c_varargin = c_varargin(2:end);
               case '-nofixit'
                  fixit = 0;
                  c_varargin = c_varargin(2:end);
                  %                     case 'units'
                  %                         input_units = c_varargin{2};
                  %                         c_varargin = c_varargin(2:end);
            end
         end
         
         %   if isa(input_units, 'char')
         %     input_units = time_units(input_units);
         %   end
         
         
         
         if (~isempty(s)) || (~isempty(e))
            
            if ~(isa(s, 'numeric') && isa(e, 'numeric'))
               error('start and stop must be numeric arrays');
            end
            
            
            if all(size(s) ~= 1) || all(size(e) ~= 1)
               error('start and stop must be 1-D arrays');
            end
            
            s = s(:);
            e = e(:);
            
            
            if ~fixit
               if  length(s) ~= length(e)
                  error('s and e must be of the same length');
               end
               
               if(any(s> e))
                  error('it must be s(i) < e(i) for any i');
               end
               
               if(any(diff(s) < 0))
                  error('s must be sorted');
               end
               
               if(any(diff(e) < 0))
                  error('e must be sorted');
               end
               
               
            elseif ~isempty(s) && ~isempty(e)
               
               mm = [s(:) ; e(:)];
               mz = [zeros(length(s),1) ; ones(length(e),1)];
               [mm, mx] = sort(mm);
               mz = mz(mx);
               good_ix = find(diff(mz) == 1);
               s = mm(good_ix);
               e = mm(good_ix+1);
               
            end
            
            if any(s ~= sort(s))
               [s, ix] = sort(s);
               e = e(ix);
            end
            
         end
         
         %             if ~isempty(O.units)
         %                 if isempty(input_units)
         %                     input_units = time_units('ts');
         %                 end
         %                 cnvrt  = convert(input_units, O.units);
         %             else
         %                 cnvrt = 1;
         %             end
         
         O.start = double(s(:))';
         O.stop = double(e(:))';
         %             O.units = units('time', 'ts');
         % O = class(O, 'intervalSet');
         
      end
   end
end
