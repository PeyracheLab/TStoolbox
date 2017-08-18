function display(obj) 
warning off
disp(sprintf('%s object', class(obj)))
disp(struct(obj))
warning on