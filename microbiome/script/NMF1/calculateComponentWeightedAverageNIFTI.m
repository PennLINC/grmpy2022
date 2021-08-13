function [] = calculateComponentWeightedAverageNIFTI(dataList,resultsDir,numBases)

% dataList: .csv file containing the images for which the coefficients need
%           to be calculated. Full path for every image file is given in
%           every line
% resultsDir: directory where the NMF results are (i.e., the level where 
%             the NumBases folder is placed)
% numBases: determines the solution for which one wants to calculate 
%           subject coefficients

     dataPath=[resultsDir '*.nii'];        
    
    % loading estimated non-negative components
    listing = dir(dataPath);
;
   
    for i=1:numBases
        nii = load_untouch_nii([resultsDir listing(i).name]);
        B(:,i) = double(nii.img(:)');        
    end
    
    % normalize to sum to 1
    Blen = sum(B,1);
    if any(Blen==0)
        Blen(Blen==0) = 1;
    end
    nB = bsxfun(@times,B,1./Blen) ;
        
    % since the size and number of files is such that we can not manage
    % in batch mode, we are going to calculate weighted average values
    % subject by subject
    
    % read list
    fid=fopen(dataList,'r');
    if (fid == -1)
        error(['extractBases:calculateComponentWeightedAverage ','Can not open ' list ' file.']);
    end
    datafullpath = textscan(fid,'%s\n');
    fclose(fid);
    
    datafullpath = datafullpath{1,1} ;
    datafullpath = cellstr(datafullpath) ;
    count = numel(datafullpath);
    
    fid = fopen([resultsDir  'cmpWeightedAverageNumBases_' num2str(numBases) '.csv'],'w');
    frmtWrite='%s,';
    frmtWrite=[frmtWrite repmat('%f,',1,numBases-1)];
    frmtWrite=[frmtWrite '%f\n'];
    
    wA = zeros(count,numBases) ;
    for i=1:count
        nii = load_untouch_nii(datafullpath{i});
        wA(i,:) = double(nii.img(:)')*nB;
        fprintf(fid,frmtWrite,datafullpath{i},wA(i,:)');
    end
    fclose(fid);         
