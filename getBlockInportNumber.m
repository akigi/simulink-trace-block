function number_of_ports = getBlockInportNumber(block)

block_port_handles = get_param(block, 'PortHandles');
number_of_ports = length(block_port_handles.Inport);