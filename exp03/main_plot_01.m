clc;clear;close all;

pnList = [30,  40,  40,  40,  45,  45,  60, 60];
srList = [125, 120, 115, 110, 105, 100, 95, 90];
coList = [0.8, 0.85,0.90,0.95,0.99];

tempArr = zeros(length(pnList), length(coList));

for ii = 1:length(pnList)
    for cc = 1:length(coList)
        Para.minCover      = coList(cc);
        Para.pointNum      = pnList(ii);
        Para.sensorRange   = srList(ii); 
        Para.name = "rr_EHPSO_" + string(100*Para.minCover) + "_" + string(Para.sensorRange);
        pop = load(Para.name, "BestPop");
        pop2 = pop.BestPop{1};
        popSize = size(pop2, 1);
        tempArr(ii, cc) = popSize;
    end
end


colors = ["[0, 0, 0]",       "[0, 0, 0.5]",        "[0.39, 0.58, 0.92]",  ...
          "[0.6, 0.8, 0.2]", "[0.95, 0.64, 0.37]", "[1, 0.84, 0]", ...
          "[0, 0.75, 1]",    "[0.13, 0.54, 0.13]"];
Marker = ["o", "+", "*", "s", "d", "^", "h", "x"];
names = ["$C_{obj}=80\%$", "$C_{obj}=85\%$", "$C_{obj}=90\%$", "$C_{obj}=95\%$", "$C_{obj}=99\%$"];

hold on
leg(5) = "";
for i = 1:5
    plot(srList, tempArr(:,i), 'Color', colors(i), 'Marker', Marker(i), 'MarkerSize', 10, 'LineWidth', 2)
    leg(i) = names(i);
end
xlabel('Sensing radius/m','FontName', 'Times New Roman')
ylabel('Number of sensors','FontName', 'Times New Roman')
legend(leg, 'Location','northeast', "Interpreter","latex")

% exportgraphics(gcf, "Line.pdf", "ContentType", "vector")