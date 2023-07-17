function J = myCostFcnwSlack(stage, x, u, dmv, e, pv)
    
    % electricity cost, slack variable for soft constraints (for the house ...
    % temperature), and manipulated vairable move suppression
    J = 1e4*pv*u(2) + 1e5*(e(1) + e(2)) + 0.05*(dmv^2);

end