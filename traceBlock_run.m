clc;

target_block = gcb;

unhilite_gcs;

r = struct('name', get_param(target_block, 'Name'), 'children', []);
t = []
r.children = traceBlock(gcs, target_block, r)