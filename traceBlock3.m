function children = traceBlock3(sys, blk, parent)
disp('--traceBlock3--')

% sys = gcs
% blk = gcb

blk_name = get_param(blk, 'Name');
blk_fullname = getfullname(blk);
blk_h = get_param(blk, 'Handle');
blk_inportnum = getBlockInportNumber(blk);
disp(['対象:' blk_fullname]);

% ハイライト
hilite_system(blk_h);

% open system if not opened
if ~bdIsLoaded(bdroot(sys))
    sys_h = load_system(sys);
    sys_name = get_param(sys_h, "Name");
    disp([sys_name 'was loaded.']);
end

children = [];
traced_inports = [];


for i=1:blk_inportnum
    % 接続元ブロックを取得
    [srcblk, srcblk_portnumber] = getSrcBlock(blk, i);
    
    hilite_system(srcblk);

    srcblk_h = get_param(srcblk, 'Handle');
    srcblk_name = get_param(srcblk, 'Name');
    srcblk_fullname = getfullname(srcblk);
    srcblk_sys = get_param(srcblk, 'Parent');
    srcblk_sys_isroot = ~contains(string(srcblk_sys), "/");
    srcblk_blocktype = get_param(srcblk, 'BlockType');
    srcblk_blocktype_isinport = strcmp(srcblk_blocktype, 'Inport');
    srcblk_blocktype_issubsystem = strcmp(srcblk_blocktype, 'SubSystem');
    
    r_1 = struct('name', '', 'children', []);
    r_1.name = srcblk_name;
    disp(['接続元:' srcblk_fullname]);    
    
    if srcblk_blocktype_issubsystem
        % 接続元ブロックがサブシステムブロックである場合の処理
        [srcblock_subsystem_h, srcblock_portnumber] = getSrcBlock(blk, i);
        srcblock_subsystem_sys = getfullname(srcblock_subsystem_h);
        srcblock_subsystem_outports = find_system(srcblock_subsystem_h, 'SearchDepth', 1, 'BlockType', 'Outport');
        srcblock_subsystem_outport = srcblock_subsystem_outports{srcblock_portnumber};
        r_1_children = traceBlock3(srcblock_subsystem_sys, srcblock_subsystem_outport, r_1);
    elseif srcblk_blocktype_isinport && ~srcblk_sys_isroot
        % 接続元ブロックがサブシステムの中に存在しているInportブロックである場合の処理
        [srcblock_subsystem_outside_srcblock, srcblock_subsystem_outside_portnumber] = getSubsystemOutsideSrcBlock(srcblk);
        srcblock_subsystem_outside_srcblock_sys = get_param(srcblock_subsystem_outside_srcblock, 'Parent');
        r_1_children = traceBlock3(srcblock_subsystem_outside_srcblock_sys, srcblock_subsystem_outside_srcblock, r_1);
    else
        r_1_children = traceBlock3(srcblk_sys, srcblk_h, r_1);
    end
    r_1.children = r_1_children;
    
    children = [children; r_1];

    if srcblk_sys_isroot && srcblk_blocktype_isinport
        traced_inports = [traced_inports; srcblk_h]
    end
end

% children = parent.children;
