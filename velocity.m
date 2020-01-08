% Function to calculate the velocity from a set of points
% vel_output - vector of velocities for each independent point
% position_1 - vector of points in first position
% position_2 - vector of points in second position
% time_1 - first time position
% time_2 - second time position


function vel_output = velocity(position_1, position_2, time_1, time_2)
    
    delta_time = time_2 - time_1;
    distance = position_2 - position_1;
    vel_output = distance / delta_time;

end