% Function to calculate pose of the humanoid respect to the global
% reference frame 
% anglesIdx - matrix with angles
% isLeft - is left foot supporting, if not right foot is supporting
% mode - FULL mode obtains all transformation matrices of all the joints,
%        FOOT mode obtains transformation matrix of the foot
% output 

function [output] = calcGlobalPose(angles, isLeft, mode, position_ref)
    outTrans = eye(3,3);
    
    if isLeft == true 
        order = [ -8, -6; -6, -4; -4, -2; 3, 2; 5, 3; 7, 5];
    else
        order = [ -7, -5; -5, -3; -3, -2; 4, 2; 6, 4; 8, 6];        
    end
    
    %transformation matrix for each point in global (foot) reference frame
    %bodies: shanks, thighs, trunk, foot
    for idx = 2:size(order,1)+1
        params = order(idx - 1,:);
        ang = sign(params(1)) * angles(abs(params(1)));
        pos = sign(params(2)) * position_ref(abs(params(2)), :);
        outTrans(:,:,idx) = outTrans(:,:,idx-1)*trans(ang, pos);
    end
    
    switch mode
        case 0
            % Transformation matrix for each point in global (foot) reference frame
            % bodies: arms
            outTrans(:,:,idx + 1) = outTrans(:,:,3)*trans(angles(1), position_ref(1,:));
            outTrans(:,:,idx + 2) = outTrans(:,:,3)*trans(angles(2), position_ref(1,:));
            output = outTrans(:,:, 2:end);
                
        case 1
            output = outTrans(:,:,end);
    end
end