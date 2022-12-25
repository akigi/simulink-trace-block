function route = traceSignalFromOutToIn(sys, signal_name, options)
%traceSignalFromOutToIn - Trace signal in a model.
%
% Syntax: route = traceSignalFromOutToIn(model, signal_name, options)

% open system if not opened
if ~bdIsLoaded(sys)
    sys_h = load_system(sys);
    sys_name = get_param(sys_h, "Name");
end

% get outport
founds = find_system(sys_h, signal_name, 'SearchDepth', 1, 'BlockType', 'Outport');
if len(founds) > 1
    disp('Caution: There are 2 or more outports named as signal_name'):
end
blk_origin = founds(1);

blk = blk_origin;
lines = get_param(blk, 'LineHandles');
pc = get_param(blk, 'PortConnectivity');

for i =1:len(pc.SrcBlock)
    % 接続元ブロックを取得
    line = lines.Inport(i);

    srcblk = pc.SrcBlock(i);
    srcblk_name = get_param(srcblk, 'Name')

    % 接続元ブロックの種別により、中に入るか、中身を無視するか、を決める。
    % サブシステム
    srcblk_blocktype = get_param(srcblk, 'BlockType')
    if srcmp(srcblk_blocktype, 'Subsystem')
        % repeat
    else
        srcblk_pc = get_param(srcblk, 'PortConnectivity');
        for j=1:len(srcblk_pc.SrcBlock)
            srcblk_srcblk = srcblk_pc.SrcBlock(j);
            srcblk_srcblk_name = get_param(srcblk_srcblk, 'Name')
            % repeae
            t
        end
    end


    

end