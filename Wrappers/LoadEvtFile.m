function [st,en] = LoadEvtFile(fbasename)

fname = [fbasename];
if ~exist(fname,'file')
    error('No ''cel'' evt file!')
end

fid = fopen(fname,'r');
evt = textscan(fid,'%f %s %s');
fclose(fid);

nbC = length(evt{1})/2;
if round(nbC)~=nbC
    error('Number of cel events must be even')
end

st = evt{1}(1)/1000;
en = evt{1}(2)/1000;
