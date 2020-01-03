% Function to calculate the transformation matrix
% fi - transformation matrix output
% ang - input angle matrix, 8 angles
% coordinate - position, respect to the reference frame

function fi = rot(ang)
    
    fi = [cos(ang) -sin(ang);
        sin(ang) cos(ang)];
end