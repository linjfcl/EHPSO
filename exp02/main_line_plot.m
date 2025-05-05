clc;clear;close all;
addpath("..\")

figure
hold on
namess=["PSO_1995", "PSO", "PSO_R1", "EHPSO", "EHPSO_R1", "EHPSO_R2"]; % "EHPSO", "EHPSO_R1", "EHPSO_R2"
laanames = ["PSO_1995", "PSO_1998", "PSO_1998_init", "EHPSO", "EHPSO_nInit", "EHPSO_nAdapt"];

colors = ["[0, 0, 0]",       "[0, 0, 0.5]",        "[0.39, 0.58, 0.92]",  ...
          "[0.6, 0.8, 0.2]", "[0.95, 0.64, 0.37]", "[1, 0.84, 0]", ...
          "[0, 0.75, 1]",    "[0.13, 0.54, 0.13]"];
Marker = ["o", "+", "*", "s", "d", "^", "h", "x"];
legsa(length(namess)) = "";
for aiii = 1:length(namess)
    load("rr_" + namess(aiii) + "_e02");
    plot(cg_curve, 'Color', colors(aiii), 'Marker', Marker(aiii), 'MarkerSize', 8, 'LineWidth', 2, "MarkerIndices", (1:100:1000));
    legsa(aiii) = laanames(aiii);
end
ylim([-1, -0.78])
legend(legsa, 'Location','northwest', "Interpreter","none")

rectangle('Position', [900, -0.99, 100, 0.01], ...
          'EdgeColor', 'k', 'LineWidth', 1, 'LineStyle', '--');

axInse2 = axes('Position', [0.52 0.44, 0.35, 0.35]);
hold(axInse2, 'on');
for aiii = 1:length(namess)
    load("rr_" + namess(aiii) + "_e02");
    plot(axInse2, cg_curve, 'Color', colors(aiii), 'Marker', Marker(aiii), 'MarkerSize', 8, 'LineWidth', 2, "MarkerIndices", (900:20:1000));
    legsa(aiii) = laanames(aiii);
end

xlim(axInse2, [900, 1000]);
ylim(axInse2, [-0.9858, -0.9845]);

annotation('arrow', [0.88 0.83], [0.19 0.43], 'LineWidth', 2);
