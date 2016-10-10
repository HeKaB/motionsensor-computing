function Result = feature_rawRollPitchACC(motionAcc,displ)

RawAcc = quatrot(motionAcc,displ');
AccDir = normalizeColumns(RawAcc);

F = size(RawAcc,2);

X = repmat([0;1;0],1,F);
Y = repmat([1;0;0],1,F);

Pitch = pi/2 - acos(dot(AccDir,X));
Roll  = pi/2 - acos(dot(AccDir,Y));

Result = [Roll;Pitch];

end