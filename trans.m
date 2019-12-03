% Function to calculate the transformation matrix
% T - transformation matrix output
% ang - input angle matrix, 8 angles
% coordinate - position, respect to the reference frame

function T = trans(ang, coordinate)
    
    T = [cos(ang) -sin(ang) coordinate(1);
        sin(ang) cos(ang) coordinate(2);
        0 0 1];
end