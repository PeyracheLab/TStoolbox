function O = union(varargin)

%  Computes the union of intervalSet's
%  	
%  	USAGE:
%  	O = union(O1, O2, ..., On)
%  	
%  	INPUTS:
%  	O1, O2, ..., On - intervalSet objects
%  	
%  	OUTPUTS:
%  	O - union intervalSet object

% copyright (c) 2004 Francesco P. Battaglia, debugging by Adrien Peyrache 2007
% This software is released under the GNU GPL
% www.gnu.org/copyleft/gpl.html

  
  
if nargin < 2
  error('Call with at least two arguments');
end

for i = 1:nargin
  if ~isa(varargin{i}, 'intervalSet')
    error('Arguments must be intervalSet');
  end
end

nbError = 0;

for i =1:nargin

	if length(Start(varargin{i})) > 0
		vararginN{i-nbError} = varargin{i};
	else
		nbError = nbError+1;
	end

end


if nargin-nbError>1
	
	do_string = '[start, stop] = do_union(';
	for i = 1:nargin-nbError
		do_string = [do_string 'Start(vararginN{' num2str(i) ...
			'}, ''ts''), End(vararginN{' num2str(i) '}, ''ts''), ' ...
			];
	end
	
	do_string = [do_string(1:(end-2)) ' );'];
	
	eval(do_string);
	
	O = intervalSet(start, stop);

elseif nargin == nbError+1

	O = vararginN{1};

else

	O = varargin{1};

end
	
  
