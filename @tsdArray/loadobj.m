%LOADOBJ Load filter for objects.
%   B = LOADOBJ(A) is called by LOAD when an object is loaded from a .MAT
%   file. The return value B is subsequently used by LOAD to populate the
%   workspace.  LOADOBJ can be used to convert one object type into
%   another, to update an object to match a new object definition, or to
%   restore an object that maintains information outside of the object
%   array.
%
%   If the input object does not match the current definition (as defined
%   by the constructor function), the input will be a struct-ized version
%   of the object in the .MAT file.  All the information in the original
%   object will be available for use in the conversion process.
%
%   LOADOBJ will be separately invoked for each object in the .MAT file.
%
%   LOADOBJ can be overloaded only for user objects.  LOAD will not call
%   LOADOBJ for a built-in datatype (such as double) even if @double/loadobj
%   exists.
%
%   See also LOAD, SAVEOBJ.

%   Copyright 1984-2002 The MathWorks, Inc.

function B = loadobj(A)

if any(strcmp(properties(A), 'version')) && A.version == 2
    disp('Loading tsdArray v2.0');
    B = A;
else
    disp('Converting tsdArray from v1.0 to v2.0...');
    for idx = 1:length(A.C)
        if strcmp(A.C{idx}.type, 'ts')
            S{idx} = ts(A.C{idx}.tsd.t, 'vers', 1); % add version etc.
        elseif strcmp(A.C{idx}.type, 'tsd')
            S{idx} = tsd(A.C{idx}.tsd.t, A.C{idx}.tsd.data, 'vers', 1); % add version etc.
        end
    end
    B = tsdArray(S);
end




