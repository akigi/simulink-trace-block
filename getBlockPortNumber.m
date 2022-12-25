function [number_of_ports, number_of_ports2] = getBlockPortNumber(block, port_type)


port_type_isprovided = true;

switch nargin
    case 0
        block = gcb;
        port_type_isprovided = false;
    case 1
        port_type = 'Inport';
        port_type_isprovided = false;
end

block_port_handles = get_param(block, 'PortHandles');

if port_type_isprovided 
    p = getfield(block_port_handles, port_type);
    number_of_ports = length(p);
else
    number_of_ports = length(block_port_handles.Inport);
    number_of_ports2 = length(block_port_handles.Outport);
end
