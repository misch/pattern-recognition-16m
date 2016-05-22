function groundTruth = loadGroundTruth(filename)

groundTruth = importdata(filename);
gt = cell(size(groundTruth,1),3);
for i = 1:size(groundTruth,1);
    signatureInfo = regexp(char(groundTruth(i)),'(?<writerID>\d+)-(?<signatureID>\d+)\s(?<type>\w)','names');
    gt{i,1} = signatureInfo.writerID;
    gt{i,2} = signatureInfo.signatureID;
    gt{i,3} = signatureInfo.type;
end
groundTruth = gt;