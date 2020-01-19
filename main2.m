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
COM_REF = [0, 16.4;
           0, -55;
           0, -55;
           2.3, -39;
           2.3, -39;
           1.1, -35.8;
           1.1, -35.8;
           16.7, -2.4;
           16.7, -2.4];
MASS = [ 0.696 0.091 0.091 0.241 0.241 0.192 0.192 0.149 0.149 ];
 
output_positions = [];
com_positions = [];
stateLeft = true;
switchFrames = 1;
dang = ANGLES(:,6) - ANGLES(:,7) - 0.05;
% The ANGLES(1, 2:end) is taking the first frame
for idx = 1:size(ANGLES,1)-1
    [outputLeft, comLeft] = calcGlobalPose2(ANGLES(idx, 2:end), POSITIONS_REF, COM_REF);
    
    [outputRight, comRight] = calcGlobalPose1(ANGLES(idx, 2:end), POSITIONS_REF, COM_REF);

    % if heels or toes are bellow, then switch 
    if (sign(dang(idx)) ~= sign(dang(idx+1)))
        stateLeft = ~stateLeft;
        switchFrames = [ switchFrames, idx ];
    end
    if stateLeft
        output = outputLeft;
        com = comLeft;
        text = 'L';
    else
        output = outputRight;
        com = comRight;
        text = 'R';
    end
    
    %visualize(output, com, [num2str(idx) text]);
    
    output_positions = vertcat(output_positions, output);
    com_positions = vertcat(com_positions, com);
end



% Calculate velocity for each point

% Set time vector and loop variables
output_velocities = [];
com_velocities = [];
time = ANGLES(:, 1);

for id = 1:size(output_positions,1)/2-1       
        
    % Vectors of position on a given time
    position_1 = output_positions((2*id-1):(2*id), :);
    position_2 = output_positions((2*id+1):(2*id+2), :);
    
    c_position_1 = com_positions((2*id-1):2*id, :);
    c_position_2 = com_positions((2*id+1):(2*id+2), :);

    % Time values to the corresponding positions
    time_1 = time(id, 1);
    time_2 = time(id + 1, 1);


    % Velocity calculation for X and Y components
    vel_output = velocity(position_1, position_2, time_1, time_2);
    c_vel = velocity(c_position_1, c_position_2, time_1, time_2);

    % Store velocity values
    output_velocities = vertcat(output_velocities, vel_output);
    com_velocities = vertcat(com_velocities, c_vel);
end


% Calculate acceleration for each point

% Set time vector and loop variables
output_accelerations = [];
com_accelerations = [];

for id = 1:size(output_velocities,1)/2-1
        
        
    % Vectors of position on a given time
    vel_1 = output_velocities((2*id-1):2*id, :);
    vel_2 = output_velocities((2*id+1):(2*id+2), :);

    c_vel_1 = com_velocities((2*id-1):2*id, :);
    c_vel_2 = com_velocities((2*id+1):(2*id+2), :);

    % Time values to the corresponding positions
    time_1 = time(id, 1);
    time_2 = time(id + 1, 1);


    % Velocity calculation for X and Y components
    accel_output = acceleration(vel_1, vel_2, time_1, time_2);
    c_accel = acceleration(c_vel_1, c_vel_2, time_1, time_2);

    % Store velocity values
    output_accelerations = vertcat(output_accelerations, accel_output);
    com_accelerations = vertcat(com_accelerations, c_accel);
    
end

p_ZMP = [];
figure
for id = 1:size(output_accelerations,1)/2
    pos = output_positions((2*id - 1):2*id,:);
    c_pos = com_positions((2*id - 1):2*id,:);
    c_acc = com_accelerations((2*id -1):2*id,:);
    p_zmp = zmp(c_pos,c_acc, MASS);
    p_ZMP = [p_ZMP p_zmp(1)];  
    visualize(pos,c_pos,p_zmp,id);
    pause(0.05);
end

figure
plot(p_ZMP)
hold on
for l = 2:length(switchFrames)
    xline(switchFrames(l), '--r')
end
hold off