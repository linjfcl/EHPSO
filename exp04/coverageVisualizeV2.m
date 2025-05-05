function coverage = coverageVisualizeV2(points, sensorRange, areaSize, plotCoverage, hasNCA, hasRA)

rt = sensorRange + 1;
selector = false(2*(sensorRange+1));
[rows, cols] = meshgrid(1:2*(sensorRange+1), 1:2*(sensorRange+1));
dist = sqrt((rows - rt).^2 + (cols - rt).^2);
selector(dist <= sensorRange) = true;
[x,y] = find(selector);

coverageMap = zeros(areaSize);

for i = 1:size(points, 1)
    p = points(i, :);
    p = round(p);

    x2 = x + (p(1) - rt);
    y2 = y + (p(2) - rt);

    in_range = (x2 >= 1 & x2 <= areaSize) & (y2 >= 1 & y2 <= areaSize);
    x2 = x2(in_range);
    y2 = y2(in_range);

    li = sub2ind(size(coverageMap), x2, y2);

    coverageMap(li) = coverageMap(li) + 1;

end

if(hasNCA)
    coverage = sum(coverageMap(:)>0) / (areaSize^2 - 70681); % 70681 is the area of NCA
else
    coverage = sum(coverageMap(:)>0) / areaSize^2;
end

    % Plot coverage map if requested
    if plotCoverage
        imagesc(-coverageMap);
        colormap(gray);
        axis equal;
        axis([1 areaSize 1 areaSize]);
        hold on;
        plot(points(:, 2), points(:, 1), 'r+', 'MarkerSize', 10, 'LineWidth', 2);
        titl = "$R="+sensorRange+",N="+size(points, 1)+",COVR="+coverage*100+"\%$";
        title(titl, 'FontName', 'Times New Roman',"Interpreter","latex");
        xlabel('X-axis/m', 'FontName', 'Times New Roman');
        ylabel('Y-axis/m', 'FontName', 'Times New Roman');
        set(gca, 'YDir', 'normal');
        if(hasRA) 
            center_x = 300;
            center_y = 300;
            radius = 150;
            theta = linspace(0, 2*pi, 100);
            x = center_x + radius * cos(theta);
            y = center_y + radius * sin(theta);
            h1 = fill(x, y, 'r', 'FaceAlpha', 0.3); 
            legend(h1, 'RA');
        end
        if(hasNCA) 
            center_x = 700;
            center_y = 700;
            radius = 150;
            theta = linspace(0, 2*pi, 100);
            x = center_x + radius * cos(theta);
            y = center_y + radius * sin(theta);
            h2 = fill(x, y, 'b');
            legend(h2, 'NCA');
        end
        if(hasRA && hasNCA)
            legend([h1,h2], {'RA','NCA'});
        end
        caxis([-3 0]) 
        grid on;
        hold off;
        drawnow;
        % exportgraphics(gcf, "exp03_coverage_" + sensorRange + "_" + hasRA + "_" + hasNCA + ".png")
        % exportgraphics(gcf, "exp03_coverage_" + sensorRange + "_" + hasRA + "_" + hasNCA + ".pdf", "ContentType", "vector")
     end

end
