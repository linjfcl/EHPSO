clc;clear;close all;
addpath("..\")

pnList = [30  45];
srList = [125 100];

Para.hasNCA = false;
Para.hasRA  = false;

for ii = 1:length(pnList)
    for jcc = 1:3
        if(jcc == 1)
            Para.hasNCA = false;
            Para.hasRA  = true;
        elseif(jcc == 2)
            Para.hasNCA = true;
            Para.hasRA  = false;
        elseif(jcc == 3)
            Para.hasNCA = true;
            Para.hasRA  = true;
        end
        Para.pointNum      = pnList(ii);
        Para.sensorRange   = srList(ii); 
        Para.name = "rr_EHPSO_" + string(Para.sensorRange) + "_" + string(Para.hasNCA+0) + "_" + string(Para.hasRA+0);
        load(Para.name, "BestPop");
        pop = BestPop{1};
        figure
        coverageVisualizeV2(pop(:, 1:2), Para.sensorRange, 1000, true, Para.hasNCA, Para.hasRA);
    end
end


