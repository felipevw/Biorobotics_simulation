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
                       
for idx = 1:size(ANGLES,1)
    output = calcGlobalPose1(ANGLES(idx, 2:end), POSITIONS_REF);
    
    visualize(output);
    
    pause(0.05);
end






