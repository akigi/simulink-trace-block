blk = find_system(bdroot(gcs),'type','block'); % ���f�����̃u���b�N�����X�g���܂�
for n = 1:length(blk) % �擾�����u���b�N���X�g���ŌJ��Ԃ�
    hilite_system(blk{n},'none'); % �Ώۃu���b�N��highlight���N���A
end
