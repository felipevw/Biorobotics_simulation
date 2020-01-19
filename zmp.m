function [out] = zmp(com_p, com_a, m)
    g = 9.81;
    x = com_p(1:2:end,:);
    d2x = com_a(1:2:end,:);
    y = com_p(2:2:end,:);
    d2y = com_a(2:2:end,:);
    out = sum(m.*x*g - m.*(y.*d2x - x.*d2y),2)./sum(m*g + m.*d2y,2);
    out = [out; 0];
end