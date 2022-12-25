function [srcBlockHandle, srcPortNumber] = getSubsystemOutsideSrcBlock(target_block)
% サブシステムの中にあるInportブロックが、その上位階層のどのブロックのどのポートに接続されているかを調べる関数。
% target_blockのブロックタイプがInportでない場合、エラーにより終了します。
% target_blockの配置場所がそのbdrootである場合、エラーにより終了します。
% 何も接続されていない場合、ともに-1を出力します。(getSrcBlockの仕様)

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