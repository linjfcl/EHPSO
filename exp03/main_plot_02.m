clc;clear;close all;
addpath("..\")

pnList = [30, 45];
srList = [125,100];
coList = [0.8,0.90,0.99];

tempArr = zeros(length(pnList), length(coList));

for ii = 1:length(pnList)
    for cc = 1:length(coList)
        Para.minCover      = coList(cc);
        Para.pointNum      = pnList(ii); 
        Para.sensorRange   = srList(ii);  
        Para.name = "rr_EHPSO_" + string(100*Para.minCover) + "_" + string(Para.sensorRange);
        disp(Para.name)
        load(Para.name, "BestPop");
        pop = BestPop{1};
        figure
        coverageVisualize(pop(:, 1:2), Para.sensorRange, 1000, true);
    end
end


