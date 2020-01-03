% Function to calculate pose of the humanoid respect to the global
% reference frame 
% anglesIdx - matrix with 8 angles
% isLeft - is left foot supporting, if not right foot is supporting
% output - outputs 12 position (x, y) of the body of the humanoid

function [output] = calcGlobalPose(angles, isLeft, position_ref)

    % Intro all positions of the skeleton FOR ISLEFT CASE
    % Rotation matrixes
    rot_lf_ls = rot(-angles(8));
    rot_ls_lt = rot(-angles(6));
    rot_lf_lt = rot_lf_ls * rot_ls_lt;
    rot_lt_t = rot(-angles(4));
    rot_lf_t = rot_lf_lt * rot_lt_t;
    rot_t_rt = rot(angles(3));
    rot_lf_rt = rot_lf_t * rot_t_rt;
    rot_rt_rs = rot(angles(5));
    rot_lf_rs = rot_lf_rt * rot_rt_rs;
    
    
    % Position calculation
    r_lf_ls = -position_ref(6, :)';
    r_ls_lt = -position_ref(4, :)';
    r_lt_t = -position_ref(2, :)';
    r_t_rt = position_ref(2, :)';
    r_rt_rs = position_ref(3, :)';
    r_rs_rf = position_ref(5, :)';
    
    
    
    r_lf_lt = r_lf_ls + rot_lf_ls * r_ls_lt;
    r_lf_t = r_lf_lt + rot_lf_lt * r_lt_t;
    r_lf_rt = r_lf_t + rot_lf_t * r_t_rt;
    
    r_lf_rs = r_lf_rt + rot_lf_rt * r_rt_rs;
    r_lf_rf = r_lf_rs + rot_lf_rs * r_rs_rf;
    
    % Output vector of matrixes for ISLEFT CASE
    output = [r_lf_ls r_ls_lt r_lt_t r_lf_lt r_lf_t r_lf_rt r_lf_rs r_lf_rf];

    
    % want to calculate 12 positions
    


    
    
    
end