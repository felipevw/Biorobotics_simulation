% Function to calculate the acceleration from the velocity of a set of
% points
% accel_output - vector of accelerations for each independent point
% vel_1 - vector of points in first velocity
% vel_2 - vector of points in second velocity
% time_1 - first time position
% time_2 - first time position
% 


function accel_output = acceleration(vel_1, vel_2, time_1, time_2)

    delta_time = abs(time_1 - time_2);
    delta_vel = abs(vel_1 - vel_2);
    accel_output = delta_vel / delta_time;

end