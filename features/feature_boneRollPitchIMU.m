function Result = feature_boneRollPitchIMU(motion,displ)

q_O_conj = quatconj(displ);
q_S_conj = quatconj(motion');
F = size(q_S_conj,1);

X = repmat(quatrot([0;1;0],q_O_conj'),1,F);
Y = repmat(quatrot([1;0;0],q_O_conj'),1,F);

Z = quatrot(repmat([0;0;1],1,F),q_S_conj');

Pitch = pi/2 - acos(dot(Z,X));
Roll  = pi/2 - acos(dot(Z,Y));

Result = [Roll;Pitch];

end