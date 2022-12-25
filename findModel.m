% 対象フォルダ内のモデルを全走査し、最上位階層に特定の名前のOutportブロックを持つモデルファイルを見つける関数。

target_dir_fullpath = 'models' % TODO: This should be fullpath.

slx_files = dir(fullfile(target_dir_fullpath, '*.slx'));
mdl_files = dir(fullfile(target_dir_fullpath, '*.mdl'));
modelfiles = [slx_files; mdl_files]

for i=1:length(modelfiles)
    modelfile = modelfiles(i);
    modelfile_fullpath = fullfile(modelfile.folder, modelfile.name);

    modelinfo = Simulink.MDLInfo(modelfile_fullpath);

    
end
