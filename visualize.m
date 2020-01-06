function visualize(calcGlobalPoseOutput)

    x = calcGlobalPoseOutput(1, :);
    y = calcGlobalPoseOutput(2, :);
    
    
    
    scatter(x, y, 'X')
    line([x(1) x(2)], [y(1) y(2)])
    line([x(3) x(2)], [y(3) y(2)])
    line([x(3) x(4)], [y(3) y(4)])
    line([x(3) x(5)], [y(3) y(5)])
    line([x(5) x(6)], [y(5) y(6)])
    axis([-250 250 -250 500])
   



end
