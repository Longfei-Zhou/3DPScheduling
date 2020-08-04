function [ f ] = ScheSolver(tn)
lb = zeros(1,tn*2)+0.0001;
ub = ones(1,tn*2)-0.0001;
X0 = zeros(1,tn*2)+0.5;
[~,fitnessGA] = ga(@FitnessFunction3DPSS,tn*2,[],[],[],[],lb,ub);
[~,fitnessPS] = patternsearch(@FitnessFunction3DPSS,X0,[],[],[],[],lb,ub);
[~,fitnessPSO] = particleswarm(@FitnessFunction3DPSS,tn*2,lb,ub);
[~,fitnessFMC] = fmincon(@FitnessFunction3DPSS,X0,[],[],[],[],lb,ub);
f=[fitnessGA,fitnessPS,fitnessPSO,fitnessFMC];
end