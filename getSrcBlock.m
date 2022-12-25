function [srcBlockHandle, srcPortNumber] = getSrcBlock(target_block, target_inport_number)
% �u���b�N��X�Ԗڂ̓��̓|�[�g�ɐڑ�����Ă���M�����A
% �ǂ̃u���b�N�̂ǂ̃|�[�g����o�͂��ꂽ�M���Ȃ̂����ׂ�֐��B

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

