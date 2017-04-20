niak_gb_vars
path_work = '/home/pbellec/tmp';
file_mask_1mm = [path_work filesep 'mask_thalamus_erode.nii.gz'];
file_mask_1mm_r = [path_work filesep 'mask_thalamus_erode_r.nii.gz'];
file_target = [path_work filesep 'HCP_AVG_FA.nii.gz'];
file_aal = [GB_NIAK.path_niak filesep 'template' filesep 'roi_aal.mnc.gz'];

% read aal, select thalamus and erode
[hdr,vol] = niak_read_vol(file_aal);
mask = (vol==7101)|(vol==7102);
mask = niak_morph(mask,'-erosion'); %1 mm erosion
hdr.file_name = file_mask_1mm;
niak_write_vol(hdr,mask);
% niak_montage(mask)

%resample in the FA space
clear in out opt
in.source = file_mask_1mm;
in.target = file_target;
out = file_mask_1mm_r;
opt.interpolation = 'nearest_neighbour';
niak_brick_resample_vol(in,out,opt);

