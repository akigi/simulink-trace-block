clc;

unhilite_gcs;

r = struct('name', get_param(gcb, 'Name'), 'children', []);
t = []
r.children = traceBlock(gcs, gcb, r)