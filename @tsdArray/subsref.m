function varargout = subsref(A, S)
% overload of operators for element referencing.
%
% () indexing returns a new tsdArray composed of elements of the original.
% {} indexing can only be used for a single tsdArray element, and it
%    returns the tsd contained within the tsdArray
%
%
% v2.0, Luke Sjulson, Aug 2017
% TODO: add back in text-based indexing


if strcmp(S(1).type, '{}')
   %     disp('subsref called');
   %    if length(S) > 1
   %       error('subsref defined only for one level of subscripting');
   %    end
   
   if length(S(1).subs)>1
      error('subsref does not yet support greater than 1-D indexing of tsdArrays');
   end
   
   if length(S(1).subs{:})>1
      error('If you index a tsdArray with curly braces, you can only index one element of the array');
   end
   
   if ~isnumeric(S(1).subs{1})
      error('curly brace indexing must use a number');
   end
   
   V = ver;
   V = V(1).Release;
   x = str2num(V(V>='0' & V<='9')); % matlab release year number
   if x<2015 || contains(V, 'R2015a')
      warning('Versions of matlab prior to R2015b do not index tsdArrays correctly. Time to upgrade.')
   end
   
   % accessing single TS/TSD in the array
   if length(S)==1
      varargout{1} = A.C{S.subs{1}};
      
      % calling method or getting property, no arguments
   elseif length(S)==2 && strcmp(S(2).type,'.')
      
      if isprop(A.C{S(1).subs{1}}, S(2).subs) % it's a property, not a method
         eval(['varargout{1} = A.C{S(1).subs{1}}.' S(2).subs ';']);
      else % it's a method
         [varargout{1:nargout(S(2).subs)}] = feval(S(2).subs, A.C{S(1).subs{1}});
      end
      
      % calling property or method with arguments
   elseif length(S)==3 && strcmp(S(2).type,'.') && strcmp(S(3).type, '()')
      if isprop(A.C{S(1).subs{1}}, S(2).subs) % it's a property, not a method
         if length(S(3).subs)>1
            error('subsref can not handle indexing more than one dimension');
         else
            eval(['varargout{1} = A.C{S(1).subs{1}}.' S(2).subs '([' num2str(S(3).subs{1}) ']);']);
         end
      else % it's a method
         [varargout{1:nargout(S(2).subs)}] = feval(S(2).subs, A.C{S(1).subs{1}}, S(3).subs{:});
      end
      
   else
      error('subsref can not handle that many levels of indexing');
   end
   
elseif strcmp(S(1).type, '()') % for indexing subarrays of the whole array
   
   if length(S) > 1
      error('subsref defines only for one level of subscripting for ()');
   end
   
   if length(S(1).subs) > 1
      error('indexing more than one dimension with () not supported');
   end
   
   if isnumeric(S(1).subs{1})
      varargout{1} = tsdArray(A.C(S.subs{:}));
      
   elseif isstring(S(1).subs{1}) % string indexing by searching name property
      error('string indexing not yet implemented');
      
   elseif islogical(S(1).subs{1})
      varargout{1} = tsdArray(A.C(S.subs{:}));
      
   else error('subsref can only index with numbers or logical arrays');
      
   end
   
elseif strcmp(S(1).type, '.') % for calling tsdArray methods using dot syntax
   
   if length(S)==1 % no arguments
      if all(isprop(A, S(1).subs)) % it's a property
         eval(['varargout{1} = A.' S(1).subs ';']);
      else % it's a method
         [varargout{1:nargout(S(1).subs)}] = feval(S(1).subs, A);
      end
      
   elseif length(S)==2 && strcmp(S(2).type,'()') % property/method gets arguments
      if all(isprop(A, S(1).subs)) % it's a property
         error('subsref does not support indexing properties of tsdArrays');
      else % it's a method
         [varargout{1:nargout(S(1).subs)}] = feval(S(1).subs, A, S(2).subs{:});
      end
      
   else error('subsref does not handle that type of indexing');
   end
end




