function out = getObjectParameters(obj)

if nargin == 0
    obj = gcb;
end

param_names_struct = get_param(obj, 'ObjectParameters');
param_names_cell = fieldnames(param_names_struct);

out = struct;

for i=1:length(param_names_cell)
    param_name = param_names_cell{i};
    param_value = get_param(obj, param_name);
    out = setfield(out, param_name, param_value);
end