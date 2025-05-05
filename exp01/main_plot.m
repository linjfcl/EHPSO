clc;clear;close all;
addpath("../")

names = {'exp01_EHPSO_e01', 'exp01_EHPSO_e02', 'exp01_EHPSO_e03'};

for nameIdx = 1:length(names)
    name = names{nameIdx};
    load(name);

    Fbest = mean(FBestArr);

    fprintf("%10s algorithm's average maximum coverage rate is %10.3f%%\n", name, -Fbest*100);
    
    figure;
    t = BestPop{7};    % You can set which experiment's result to plot here
    t = t(:, 1:2);
    coverageSelectorV2(t, Para.ranges, Para.areaSizeX, Para.areaSizeY, true);
end
