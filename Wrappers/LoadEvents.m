function [events,description] = LoadEvents(fbasename)

fname = [fbasename];
if ~exist(fname,'file')
    error('File does not exist')
end

fid = fopen(fname,'r');
evt = textscan(fid,'%f %s');
fclose(fid);

description = unique(evt{2});
events = cell(length(description),1);

for ii=1:length(description)
    ix = ismember(evt{2},description{ii});
    events{ii} = ts(evt{1}(ix)/1000);
end