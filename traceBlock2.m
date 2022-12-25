function children = traceBlock2(sys, blk, parent)
disp('--traceBlock2--')

% sys = gcs
% blk = gcb

blk_name = get_param(blk, 'Name');
blk_h = get_param(blk, 'Handle');
disp(['対象:' blk_name]);

% ハイライト
hilite_system(blk_h);

% open system if not opened
if ~bdIsLoaded(bdroot(sys))
    sys_h = load_system(sys);
    sys_name = get_param(sys_h, "Name");
    disp([sys_name 'was loaded.']);
end

pc = get_param(blk, 'PortConnectivity');

children = [];
traced_inports = [];

for i=1:length(pc)
    % 接続元ブロックを取得
    pc_field = pc(i);
    srcblk = pc_field.SrcBlock;
    if ~any(size(srcblk))
        disp('skip')
        continue
    end

    srcblk_h = get_param(srcblk, 'Handle');
    srcblk_name = get_param(srcblk, 'Name');
    srcblk_sys = get_param(srcblk, 'Parent');
    srcblk_sys_isroot = ~contains(string(srcblk_sys), "/");
    srcblk_blocktype = get_param(srcblk, 'BlockType');
    srcblk_blocktype_isinport = strcmp(srcblk_blocktype, 'Inport');
    srcblk_blocktype_issubsystem = strcmp(srcblk_blocktype, 'SubSystem');
    
    disp(srcblk_blocktype )
    

    r_1 = struct('name', '', 'children', []);
    r_1.name = srcblk_name;
    disp(['接続元:' r_1.name]);    
    
    if srcblk_blocktype_issubsystem
        % subsystem
        [srcblock_subsystem_h, srcblock_portnumber] = getSrcBlock(blk, i);
        srcblock_subsystem_sys = getfullname(srcblock_subsystem_h)
        srcblock_subsystem_outports = find_system(srcblock_subsystem_h, 'SearchDepth', 1, 'BlockType', 'Outport');
        srcblock_subsystem_outport = srcblock_subsystem_outports{srcblock_portnumber}
        r_1_children = traceBlock2(srcblock_subsystem_sys, srcblock_subsystem_outport, r_1);
    else
        r_1_children = traceBlock2(srcblk_sys, srcblk_h, r_1);
    end
    r_1.children = r_1_children;
    
    children = [children; r_1];

    if srcblk_sys_isroot && srcblk_blocktype_isinport
        traced_inports = [traced_inports; srcblk_h]
    end
end

% children = parent.children;
