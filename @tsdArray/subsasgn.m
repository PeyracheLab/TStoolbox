function A = subsasgn(A, S, B)

% subscript assignment not yet supported.


% overload of operator {} for element.
% if subscripts are numeric, the correspondign elements of the array are returned, if
% subscript is a string, all the tsd's are returned that contain that
% string in their name

% copyright (c) 2004 Francesco P. Battaglia
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

error('subscripted assignment for tsdArrays not yet supported');


if length(S) > 1
   error('subsref defined only for one level of subscripting');
end

if ~strcmp(S.type, '{}')
   error('subsasgn only does {} indexing');
end


num_subs = 1;
for i = 1:length(S.subs)
   if ~isa(S.subs{i}, 'numeric')
      num_subs = 0;
   end
end
if num_subs
   A.C(S.subs{:}) = {B};
   return
end

error('subscript of unrecognized type');






