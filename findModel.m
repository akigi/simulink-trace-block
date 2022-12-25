% �Ώۃt�H���_���̃��f����S�������A�ŏ�ʊK�w�ɓ���̖��O��Outport�u���b�N�������f���t�@�C����������֐��B

target_dir_fullpath = 'models' % TODO: This should be fullpath.

slx_files = dir(fullfile(target_dir_fullpath, '*.slx'));
mdl_files = dir(fullfile(target_dir_fullpath, '*.mdl'));
modelfiles = [slx_files; mdl_files]

for i=1:length(modelfiles)
    modelfile = modelfiles(i);
    modelfile_fullpath = fullfile(modelfile.folder, modelfile.name);

    modelinfo = Simulink.MDLInfo(modelfile_fullpath);

    
end
