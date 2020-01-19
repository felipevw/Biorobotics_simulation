% Function to calculate the transformation matrix
% fi - transformation matrix output
% ang - input angle matrix, 8 angles
% coordinate - position, respect to the reference frame

function R = rot(ang)
    
    R = [cos(ang) -sin(ang);
        sin(ang) cos(ang)];
end