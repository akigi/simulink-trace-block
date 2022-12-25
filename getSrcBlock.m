function [srcBlockHandle, srcPortNumber] = getSrcBlock(target_block, target_inport_number)
% �u���b�N��X�Ԗڂ̓��̓|�[�g�ɐڑ�����Ă���M�����A
% �ǂ̃u���b�N�̂ǂ̃|�[�g����o�͂��ꂽ�M���Ȃ̂����ׂ�֐��B
% �����ڑ�����Ă��Ȃ��ꍇ�A�Ƃ���-1���o�͂��܂��B

%target_block = gcb;
%target_inport_number = 1;

% get line handles
lines = get_param(target_block, 'LineHandles');
if length(lines.Inport) < target_inport_number
    fprintf('Error: Inport %d is not a number of inport ''%s''.\n', ...
                    target_inport_number, ...
                    getfullname(target_block) ...
    )
end
line = lines.Inport(target_inport_number);

if line == -1
    
    fprintf('Warning: Inport %d of ''%s'' has no line connected.\n', ...
                    target_inport_number, ...
                    getfullname(target_block) ...
    )
    srcBlockHandle = -1;
    srcPortNumber = -1;
else
    % get source port handle
    line_srcport_h = get_param(line, 'SrcPortHandle');

    % get src block and port number
    srcBlockHandle = get_param(line_srcport_h, 'Parent');
    srcPortNumber = get_param(line_srcport_h, 'PortNumber');
end
