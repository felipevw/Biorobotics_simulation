% MAIN FUNCTION OF BIOROBOTICS SIMULATION
% Program starts here
%--------------------------------------------------
% Authors:
% Felipe Verdes Wolukanis
% Mario Terres Diaz
% Jakub Pawel Galik

% Main variables
clear variables;


dataset = load("2DRobot_JointAngles.mat");


ANGLES = dataset.JointAngles;
clear dataset;
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
FULL = 0;
FOOT = 1;
% dupa
output2 = calcGlobalPose(ANGLES(1, 2:end), 1, FOOT, POSITIONS_REF)
