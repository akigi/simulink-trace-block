function children = traceBlock(sys, blk, parent)
disp('--traceBlock--')

% sys = gcs
% blk = gcb

blk_name = get_param(blk, 'Name');
blk_h = get_param(blk, 'Handle');
disp(['‘ÎÛ:' blk_name]);
hilite_system(blk_h);

% open system if not opened
if ~bdIsLoaded(sys)
    sys_h = load_system(sys);
    sys_name = get_param(sys_h, "Name");
    disp([sys_name 'was loaded.']);
end

pc = get_param(blk, 'PortConnectivity');

children = [];
traced_inports = [];

for i=1:length(pc)
    % Ú‘±Œ³ƒuƒƒbƒN‚ğæ“¾
    pc_field = pc(i);
    srcblk = pc_field.SrcBlock;
    if ~any(size(srcblk))
        disp('skip')
        continue
    end

    srcblk_h = get_param(srcblk, 'Handle');
    srcblk_name = get_param(srcblk, 'Name');
    srcblk_sys = get_param(srcblk, 'Parent');
    disp(srcblk_sys)
    srcblk_sys_isroot = ~contains(string(srcblk_sys), "/")
    srcblk_blocktype = get_param(srcblk, 'BlockType');
    srcblk_blocktype_isinport = strcmp(srcblk_blocktype, 'Inport')
    
    r_1 = struct('name', '', 'children', []);
    r_1.name = srcblk_name;
    disp(['Ú‘±Œ³:' r_1.name]);    
    
    r_1_children = traceBlock(srcblk_sys, srcblk_h, r_1);
    
    r_1.children = r_1_children;
    children = [children; r_1];

    if srcblk_sys_isroot && srcblk_blocktype_isinport
        traced_inports = [traced_inports; srcblk_h]
    end
end

% children = parent.children;
