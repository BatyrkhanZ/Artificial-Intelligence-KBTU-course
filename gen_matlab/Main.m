clear; clc;
addpath('Functions/','Datasets/');
dataset = 1; % select dataset: [1,...,7]
SocMatrix = xlsread(sprintf('SM%d.xlsx',dataset));
ReqMatrix = xlsread(sprintf('RM%d.xlsx',dataset));
d = sum(ReqMatrix,2);
DepVector = [];
for i=1:length(d)
    DepVector = [ DepVector; i*ones(ceil(d(i)),1) ];
end
nIndividuals = size(SocMatrix,1);
nGroups = size(ReqMatrix,2);

alpha = 20;
maxIterations = round(alpha*nIndividuals*log(nGroups));
Np = 50;

nExec = 20;
for i=1:nExec
    tic;
    fprintf('##### Exec.%d\n',i);
    
    [BestFitness(i), BestConstraints(i), Xbest, A] = binaryGA(Np,...
        nIndividuals, nGroups, maxIterations, SocMatrix, ReqMatrix, DepVector);
    
    fprintf('Fitness: %.4f\n',BestFitness(i));
    TimeElapsed(i) = toc;
end

fprintf('\n##### Results:\nBest: %.2f ,Time: %.2fs Max: %.4f, Mean: %.4f, Std: %.4f, Min: %.4f\n',...
A, mean(TimeElapsed), max(BestFitness), mean(BestFitness), std(BestFitness), min(BestFitness));
