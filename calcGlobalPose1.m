% Function to calculate pose of the humanoid respect to the global
% reference frame 
% anglesIdx - matrix with 8 angles
% output - outputs 13 position (x, y) of the body of the humanoid

function [out_r, out_com] = calcGlobalPose1(angles, position_ref, com_ref)

    % Rotation matrixes
    R_rf = rot(-angles(7));
    R_rs = R_rf*rot(-angles(5));
    R_rt = R_rs*rot(-angles(3));
    R_lt = R_rt*rot(angles(4));
    R_ls = R_lt*rot(angles(6));
    R_lf = R_ls*rot(angles(8));
    R_ra = R_rt*rot(angles(1));
    R_la = R_rt*rot(angles(2));
    
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
    
    r_rs = r_rf + R_rf*r_rf_rs;
    r_rt = r_rs + R_rs*r_rs_rt;
    r_t = r_rt + R_rt*r_rt_t;
    r_lt = r_t + r_t_lt;
    r_ls = r_lt + R_lt*r_lt_ls;
    r_lf = r_ls + R_ls*r_ls_lf;
    
    r_rfh = [0,0]';
    r_rft = r_rf + R_rf*r_rf_rft;
    
    r_lfh = r_lf + R_lf*r_lf_lfh;
    r_lft = r_lf + R_lf*r_lf_lft;
    
    r_ra = r_t + r_t_ra;
    r_rah = r_ra + R_ra*r_ra_rah;
    
    r_la = r_t + r_t_la;
    r_lah = r_la + R_la*r_la_lah;
    
    % Output vector of matrixes for not ISLEFT CASE
    out_r = [r_rf, r_rs, r_rt, r_t, r_ls, r_lf, r_rfh, r_rft, r_lfh, r_lft, r_ra, r_rah, r_lah];    
    out_com = [ r_t + R_rt*com_ref(1,:)', ...
                r_ra + R_ra*com_ref(2,:)', ...
                r_la + R_la*com_ref(3,:)', ...
                r_rt + R_rt*com_ref(4,:)', ...
                r_lt + R_lt*com_ref(5,:)', ...
                r_rs + R_rs*com_ref(6,:)', ...
                r_ls + R_lf*com_ref(7,:)', ...
                r_rf + R_rf*com_ref(8,:)', ...
                r_lf + R_lf*com_ref(9,:)'];
    
end