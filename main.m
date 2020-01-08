% MAIN FUNCTION OF BIOROBOTICS SIMULATION
% Program starts here
%--------------------------------------------------
% Authors:
% Felipe Verdes Wolukanis
% Mario Terres Diaz
% Jakub Pawel Galik

% Variables definition
dataset = load("2DRobot_JointAngles.mat");
ANGLES = dataset.JointAngles;
POSITIONS_REF = [0, 72; 
                0, -72; 
                0, -122.5; 
                0, -122.5; 
                0, -123; 
                0, -123; 
                -14, -12.1; 
                -14, -12.1; 
                58, -12.1; 
                58, -12.1];
 
output_positions = [];
% The ANGLES(1, 2:end) is taking the first frame
for idx = 1:size(ANGLES,1)
    outputLeft = calcGlobalPoseLeft(ANGLES(idx, 2:end), POSITIONS_REF);
       
    outputRight = calcGlobalPoseRight(ANGLES(idx, 2:end), POSITIONS_REF);
    
    % if heels or toes are bellow, then switch 
    if (outputLeft(2,10) <= outputLeft(2,8) || outputLeft(2,9) <= outputLeft(2,7))
        output = outputRight;
    else
        output = outputLeft;
    end
    
    visualize(output);
    
    output_positions = vertcat(output_positions, output);
    
    pause(0.05);
end




% Calculate velocity for each point

% Set time vector and loop variables
output_velocities = [];
time = ANGLES(:, 1);
j = 1;



for i = 1:size(ANGLES, 1)
    
    % Skip last calculation
    if i < size(ANGLES, 1)
        
        
        % Vectors of position on a given time
        position_1 = output_positions(j:j + 1, :);
        position_2 = output_positions(j + 2:j +3, :);

        
        % Time values to the corresponding positions
        time_1 = time(i, 1);
        time_2 = time(i + 1, 1);
    
        
        % Velocity calculation for X and Y components
        vel_output = velocity(position_1, position_2, time_1, time_2);

        
        % Store velocity values
        output_velocities = vertcat(output_velocities, vel_output);
        
        
    end
    
    
    % Jumper for position vector
    j = i * 2;
    
end


% Calculate acceleration for each point

% Set time vector and loop variables
output_accelerations = [];
j = 1;



for i = 1:size(ANGLES, 1)
    
    % Skip last calculation
    if i < size(ANGLES, 1) - 1
        
        
        % Vectors of position on a given time
        vel_1 = output_velocities(j:j + 1, :);
        vel_2 = output_velocities(j + 2:j +3, :);

        
        % Time values to the corresponding positions
        time_1 = time(i, 1);
        time_2 = time(i + 1, 1);
    
        
        % Velocity calculation for X and Y components
        accel_output = acceleration(vel_1, vel_1, time_1, time_2);

        
        % Store velocity values
        output_accelerations = vertcat(output_accelerations, accel_output);
        
        
    end
    
    
    % Jumper for position vector
    j = i * 2;
    
end












