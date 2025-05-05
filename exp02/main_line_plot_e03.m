clc;clear;close all;
addpath("..\")

figure
hold on
namess=["PSO_1995", "PSO", "PSO_R1", "EHPSO", "EHPSO_R1", "EHPSO_R2"]; % "EHPSO", "EHPSO_R1", "EHPSO_R2"
llxnames = ["PSO_1995", "PSO_1998", "PSO_1998_init", "EHPSO", "EHPSO_nInit", "EHPSO_nAdapt"];

colors = ["[0, 0, 0]",       "[0, 0, 0.5]",        "[0.39, 0.58, 0.92]",  ...
          "[0.6, 0.8, 0.2]", "[0.95, 0.64, 0.37]", "[1, 0.84, 0]", ...
          "[0, 0.75, 1]",    "[0.13, 0.54, 0.13]"];
Marker = ["o", "+", "*", "s", "d", "^", "h", "x"];
legsa(length(namess)) = "";
for aiii = 1:length(namess)
    load("rr_" + namess(aiii) + "_e03");
    xxxx = 1:1000/length(cg_curve):1000;
    plot(xxxx,cg_curve, 'Color', colors(aiii), 'Marker', Marker(aiii), 'MarkerSize', 8, 'LineWidth', 2, "MarkerIndices", (1:100/(1000/length(xxxx)):1000/(1000/length(xxxx))));
    legsa(aiii) = llxnames(aiii);
end
ylim([-1, -0.73])
legend(legsa, 'Location','northeast', "Interpreter","none")

