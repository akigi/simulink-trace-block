function route = traceBlock2(sys, blk, options)

% sys = gcs
% blk = gcb

if options.first
    options.route = struct('name', '', 'children', [])
    options.first = 0
    options.count = 0
end

r = struct('name', '', 'children', []);
blk_name = get_param(blk. 'Name');
r.name = blk_name;

options.count = options.count + 1

% open system if not opened
if ~bdIsLoaded(sys)
    sys_h = load_system(sys);
    sys_name = get_param(sys_h, "Name");
end

lines = get_param(blk, 'LineHandles');
pc = get_param(blk, 'PortConnectivity');

for i=1:length(pc)
    % 接続元ブロックを取得
    pc_field = pc(i);
    srcblk = pc_field.SrcBlock;
    if ~srcblk
        continue;
    end
    srcblk_name = get_param(srcblk, 'Name')
    r_1 = struct('name', '', 'children', []);
    r_1.name = srcblk_name;
    
    r.children = [r.children; r_1];
    
    % 接続元ブロックの種別により、中に入るか、中身を無視するか、を決める。
    % サブシステム
    srcblk_blocktype = get_param(srcblk, 'BlockType')
    if strcmp(srcblk_blocktype, 'Subsystem')
        % repeat
    else
        traceBlock(srcblk_srcblk_sys, srcblk_srcblk_h, options);    
        
%     else
%         srcblk_pc = get_param(srcblk, 'PortConnectivity')
%         for j=1:length(srcblk_pc)
%             srcblk_pc_field = srcblk_pc(j);
%             srcblk_srcblk = srcblk_pc_field.SrcBlock;
%             if srcblk_srcblk    
%                 srcblk_srcblk_name = get_param(srcblk_srcblk, 'Name')
%                 srcblk_srcblk_sys =  get_param(srcblk_srcblk, 'Parent')
%                 srcblk_srcblk_path =  [srcblk_srcblk_sys  '/' srcblk_srcblk_name]
%                 srcblk_srcblk_h =  get_param(srcblk_srcblk, 'Handle')
%                 
%                 traceBlock(srcblk_srcblk_sys, srcblk_srcblk_h, options);
%                 
%                 % repeae
%             end
%             
%         end
    end
end


%route = options.route
route = options
