% This function visualizes the velocity and acceleration in X and Y axis
% of a certain point
% velocities - velocities vector input
% accelerations - acceleration vector input
% fromVal - Select initial frame value to visualize
% toVal - Select last frame value to visualize
% select_point - Select the point to visualize


function visualize_vel_acc(velocities, accelerations, fromVal, toVal, select_point)
    
    % Velocity visualization
    velocities = velocities(fromVal:toVal, :);
    
    
    % Acceleration visualization
    accelerations = accelerations(fromVal:toVal, :);
   
    
    % Rearrange all points
    x1_vel = [];
    y1_vel = [];
    for i = 1:2:size(velocities, 1)
        
        pre_x_vel = velocities(i, select_point);
        pre_y_vel = velocities(i + 1, select_point);
        
        x1_vel = horzcat(x1_vel, pre_x_vel);
        y1_vel = horzcat(y1_vel, pre_y_vel);
        
    end
    
    % Rearrange all points
    x2_acc = [];
    y2_acc = [];
    for i = 1:2:size(accelerations, 1)
        
        pre_x_acc = accelerations(i, select_point);
        pre_y_acc = accelerations(i + 1, select_point); 
        
        x2_acc = horzcat(x2_acc, pre_x_acc);
        y2_acc = horzcat(y2_acc, pre_y_acc);
        
    end
    
    
    % Plotting routine
    subplot(4,1,1);
    
    plot(x1_vel)
    title('Velocity values')
    xlabel('Frames')
    ylabel('X velocity values [m/s]')


    subplot(4,1,2);
        
    plot(y1_vel)
    xlabel('Frames')
    ylabel('Y velocity values [m/s]')
    
    
    subplot(4,1,3);
    
    plot(x2_acc)
    title('Acceleration values')
    xlabel('Frames')
    ylabel('X acceleration values [m/s2]')
    
    
    subplot(4,1,4);
    
    plot(y2_acc)
    title('Acceleration values')
    xlabel('Frames')
    ylabel('X acceleration values [m/s2]')

end