function B = subsref(A, S)
% overload of operator {} for element referencing. if subscripts are
% numieric, the correspondign elements of the array are returned, if
% subscript is a string, all the tsd's are returned that contain that
% string in their name

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

if length(S) > 1
   error('subsref defined only for one level of subscripting');
end

if strcmp(S.type, '{}')
   %     disp('subsref called');
   if length(S.subs{:})>1
      error('If you index a tsdArray with curly braces, you can only index one element of the array');
   end
   
   V = ver;
   V = V(1).Release;
   x = str2num(V(V>='0' & V<='9')); % matlab release year number
   if x<2015 || contains(V, 'R2015a')
      warning('Versions of matlab prior to R2015b do not index tsdArrays correctly.')
   end
   
   B = A.C{S.subs{:}};
   

   
   % % below is the old code, which implemented text indexing. Should
%    % incorporate at some point
   %     num_subs = 1;
   %     for i = 1:length(S.subs)
   %         if ~isa(S.subs{i}, 'numeric')
   %             num_subs = 0;
   %         end
   %     end
   %
   %     if num_subs
   %         B = A.C{S.subs{:}};
   %         return
   %     elseif length(S.subs) == 1
   %         if ischar(S.subs{1})
   %             k = S.subs{1};
   %             ix = [];
   %             for i = 1:length(A.C)
   %                 n = Name(A.C);
   %                 if length(n) >= length(k)
   %                     if ~isempty(findstr(n, k))
   %                         ix = [ix i];
   %                     end
   %                 end
   %
   %             end
   %             B = A.C{ix};
   %             return
   %         end
   %     end
   %
   %     error(lasterr);
   
   
elseif strcmp(S.type, '()')
   B = A.C(S.subs{:});
   B = tsdArray(B);
   
   
end




