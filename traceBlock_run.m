clc;

blk = find_system(bdroot(gcs),'type','block'); % モデル内のブロックをリストします
for n = 1:length(blk) % 取得したブロックリスト数で繰り返し
    hilite_system(blk{n},'none'); % 対象ブロックのhighlightをクリア
end

r = struct('name', get_param(gcb, 'Name'), 'children', []);
t = []
r.children = traceBlock(gcs, gcb, r)