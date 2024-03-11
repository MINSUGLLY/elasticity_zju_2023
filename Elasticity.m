function maxStress = Elasticity(L, h, t, E, nu, p)
    q2d = p * t;
    I = h^3 * t / 12;
    sigmas = []; 
    for x = 0:0.01:L
        for y = -0.5*h:0.01:0.5*h
            sigma_x = -(q2d*x^2*y)/(2*I)+q2d/(2*I)*(2/3*y^3-h^2/10*y);
            sigma_y = -q2d/2*(1-3*y/h+4*y^3/h^3);
            tau_xy = q2d/(2*I)*(y^2-h^2/4)*x;
            sigma = (sigma_x^2 + sigma_y^2 + (sigma_x - sigma_y)^2 + 6 * tau_xy^2)^0.5 / 2^0.5;
            sigmas(end+1) = sigma;
        end
    end
    maxStress = max(sigmas);
end