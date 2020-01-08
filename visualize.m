function visualize(calcGlobalPoseOutput)

    x = calcGlobalPoseOutput(1, :);
    y = calcGlobalPoseOutput(2, :);
    
    
    scatter(x, y, 'X')
    %body visualization
    line([x(1) x(2)], [y(1) y(2)])
    line([x(3) x(2)], [y(3) y(2)])
    line([x(3) x(4)], [y(3) y(4)])
    line([x(3) x(5)], [y(3) y(5)])
    line([x(5) x(6)], [y(5) y(6)])
    
    %standing foot visualization
    line([x(7) x(1)], [y(7) y(1)])
    line([x(7) x(8)], [y(7) y(8)])
    line([x(8) x(1)], [y(8) y(1)])
    
    %moving foot visualization
    line([x(9) x(6)], [y(9) y(6)])
    line([x(9) x(10)], [y(9) y(10)])
    line([x(10) x(6)], [y(10) y(6)])
    
    %arms visualization
    line([x(4) x(11)], [y(4) y(11)])
    line([x(11) x(12)], [y(11) y(12)])
    line([x(11) x(13)], [y(11) y(13)])
    axis([-250 250 -50 450])
   



end
