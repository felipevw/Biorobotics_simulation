% Function to calculate pose of the humanoid respect to the global
% reference frame 
% anglesIdx - matrix with 8 angles
% output - outputs 13 position (x, y) of the body of the humanoid

function [out_r, out_com] = calcGlobalPoseRight(angles, position_ref, com_ref)

    % Intro all positions of the skeleton FOR not ISLEFT CASE
    % Rotation matrixes
    R_rf = eye(2);
    R_rs = rot(-angles(7));
    R_rt = rot(-angles(7)-angles(5));
    R_t = rot(-angles(7)-angles(5)-angles(3));
    R_lt = rot(-angles(7)-angles(5)-angles(3) + angles(4));
    R_ls = rot(-angles(7)-angles(5)-angles(3) + angles(4) + angles(6));
    R_lf = rot(-angles(7)-angles(5)-angles(3) + angles(4) + angles(6) + angles(8));
    R_ra = rot(-angles(7)-angles(5)-angles(3) + angles(1));
    R_la = rot(-angles(7)-angles(5)-angles(3) + angles(2));
    
    % Position calculation
    r_rf = -position_ref(7, :)';
    r_rf_rft = position_ref(9, :)';
    r_rf_rs = -position_ref(5, :)';
    r_rs_rt = -position_ref(3, :)';
    r_rt_t = -position_ref(2, :)';
    r_t_lt = position_ref(2, :)';
    r_lt_ls = position_ref(4, :)';
    r_ls_lf = position_ref(6, :)';
    r_lf_lfh = position_ref(8, :)';
    r_lf_lft = position_ref(10, :)';
    r_t_ra = position_ref(1, :)';
    r_ra_rah = [0, -150]';
    r_t_la = position_ref(1, :)';
    r_la_lah = [0, -150]';
    
    r_rs = r_rf + R_rs*r_rf_rs;
    r_rt = r_rs + R_rt*r_rs_rt;
    r_t = r_rt + R_t*r_rt_t;
    r_lt = r_t + R_lt*r_t_lt;
    r_ls = r_lt + R_ls*r_lt_ls;
    r_lf = r_ls + R_lf*r_ls_lf;
    
    r_rfh = [0,0]';
    r_rft = r_rf + R_rf*r_rf_rft;
    
    r_lfh = r_lf + R_lf*r_lf_lfh;
    r_lft = r_lf + R_lf*r_lf_lft;
    
    r_ra = r_t + R_t*r_t_ra;
    r_rah = r_ra + R_ra*r_ra_rah;
    
    r_la = r_t + R_t*r_t_la;
    r_lah = r_la + R_la*r_la_lah;
    
    % Output vector of matrixes for not ISLEFT CASE
    out_r = [r_rf, r_rs, r_rt, r_t, r_ls, r_lf, r_rfh, r_rft, r_lfh, r_lft, r_ra, r_rah, r_lah];    
    out_com = [ r_t + R_t*com_ref(1,:)', ...
                r_ra + R_ra*com_ref(2,:)', ...
                r_la + R_la*com_ref(3,:)', ...
                r_rt + R_rt*com_ref(4,:)', ...
                r_lt + R_lt*com_ref(5,:)', ...
                r_rs + R_rs*com_ref(6,:)', ...
                r_ls + R_ls*com_ref(7,:)', ...
                r_rf + R_rf*com_ref(8,:)', ...
                r_lf + R_lf*com_ref(9,:)'];
    
end