%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This function reduces the dimensionality of continuous features to a
% lower dimension according to a method described by Li, 2005.
% 
% Input:
% -Input cell of Continuous features
% 
% Output:
% Matrix containing low dimensional data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function FeatMatrix = prepareContFeatForSVM(InputCell)

vkCell = cell(0,1);
if(~isempty(InputCell{1,1}))
lambdaKCell = cell(0,1);
for k = 1:length(InputCell)
    currFeatM = InputCell{k,1}';
    [~,S,V] = svd(currFeatM,0);
    vk = V(:,1);
    lambdak = diag(S);
    lambdak = lambdak/norm(lambdak);
    vkCell{k,1} = vk';
    lambdaKCell{k,1} = lambdak';
end

SM = cell2mat(vkCell);
[~,~,VPr] = svd(SM'*SM);
T = SM*VPr;

NegVal = find(T(:,1)<0);
for jh = 1:length(NegVal)
    T(NegVal(jh),:) = -T(NegVal(jh),:);
end

lamMat = cell2mat(lambdaKCell);
FeatMatrix = [T lamMat];
else
    FeatMatrix = [];
end

end