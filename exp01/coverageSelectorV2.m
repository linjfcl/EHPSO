function [coverageMap, outCounter] = coverageSelectorV2(points, ranges, areaSizeX, areaSizeY, plotCoverage)

if nargin < 5 || isempty(plotCoverage)
    plotCoverage = false;
end

sensorRange = max(ranges);
rt = sensorRange + 1;
selector = false(2*rt);
[rows, cols] = meshgrid(1:2*rt, 1:2*rt);
dist = sqrt((rows - rt).^2 + (cols - rt).^2);
selector(dist <= sensorRange) = true;
%[x,y] = find(selector);

outCounter = 0;

coverageMap = zeros(areaSizeY, areaSizeX);

[rg, idx] = sort(ranges);
points2 = points(idx, :);

pr = -1;

for i = 1:size(points2, 1)
    p = points2(i, :);
    p = round(p);

    if(pr ~= rg(i))
        rt2 = rg(i) + 1;
        selector2 = imresize(selector, [2*rt2, 2*rt2]);
        [x,y] = find(selector2);
    end

    x2 = x + (p(1) - rt2);
    y2 = y + (p(2) - rt2);

    in_range = (x2 >= 1 & x2 <= areaSizeX) & (y2 >= 1 & y2 <= areaSizeY);
    x2 = x2(in_range);
    y2 = y2(in_range);
    
    outCounter = outCounter + sum(~in_range);

    li = sub2ind(size(coverageMap), y2, x2);

    coverageMap(li) = coverageMap(li) + 1;

end

if plotCoverage
    imagesc(-coverageMap);
    colormap(gray);
    axis equal;
    axis([1 areaSizeX 1 areaSizeY]);
    hold on;
    plot(points(:, 1), points(:, 2), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
    % title('Sensor Coverage', 'FontName', 'Times New Roman');
    xlabel('X-axis/m', 'FontName', 'Times New Roman');
    ylabel('Y-axis/m', 'FontName', 'Times New Roman');
    caxis([-3 0]) 
    set(gca, 'YDir', 'normal');
    grid on;
    hold off;
    drawnow;
end
