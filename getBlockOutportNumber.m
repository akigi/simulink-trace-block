function number_of_ports = getBlockOutportNumber(block)

block_port_handles = get_param(block, 'PortHandles');
number_of_ports = length(block_port_handles.Outport);