function [srcBlockHandle, srcPortNumber] = getSubsystemOutsideSrcBlock(target_block)
% �T�u�V�X�e���̒��ɂ���Inport�u���b�N���A���̏�ʊK�w�̂ǂ̃u���b�N�̂ǂ̃|�[�g�ɐڑ�����Ă��邩�𒲂ׂ�֐��B
% target_block�̃u���b�N�^�C�v��Inport�łȂ��ꍇ�A�G���[�ɂ��I�����܂��B
% target_block�̔z�u�ꏊ������bdroot�ł���ꍇ�A�G���[�ɂ��I�����܂��B
% �����ڑ�����Ă��Ȃ��ꍇ�A�Ƃ���-1���o�͂��܂��B(getSrcBlock�̎d�l)

if nargin == 0
    target_block = gcb;
end

target_block_type = get_param(target_block, 'BlockType');

% check target_block_type
assert(strcmp(target_block_type, 'Inport'), ...
        ['Error: This function is only work for Inport block in a subsystem.\n' ...
        '''%s'' is %s, not Inport.\n'], ...
        getfullname(target_block), target_block_type);

% check not bdroot
assert(~strcmp(bdroot, get_param(target_block, 'Parent')), ...
        ['Error: This function is only work for Inport block in a subsystem.\n' ...
        '''%s'' is Inport, but in its bdroot.\n'], ...
        getfullname(target_block), target_block_type);

% get inport number
port_number = str2num(get_param(target_block, 'Port'));

% get current subsystem block handle
subsys = get_param(target_block, 'Parent');
subsys_h = get_param(subsys, 'Handle');

% get upward src block
[srcBlockHandle, srcPortNumber] = getSrcBlock(subsys_h, port_number);