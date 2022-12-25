function [srcBlockHandle, srcPortNumber] = getSrcBlock(target_block, target_inport_number)
% ブロックのX番目の入力ポートに接続されている信号が、
% どのブロックのどのポートから出力された信号なのか調べる関数。

%target_block = gcb;
%target_inport_number = 1;

% get line handles
lines = get_param(target_block, 'LineHandles');
if length(lines.Inport) < target_inport_number
    disp('Error: target_inport_number is over number of target_block''s inports.')
end
line = lines.Inport(target_inport_number);

% get source port handle
line_srcport_h = get_param(line, 'SrcPortHandle');

% get src block and port number
srcBlockHandle = get_param(line_srcport_h, 'Parent');
srcPortNumber = get_param(line_srcport_h, 'PortNumber');

