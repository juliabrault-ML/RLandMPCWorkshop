function J = myCostFcnwSlack(stage, x, u, dmv, e, pv)

    J = 1e4*pv*u(2) + 1e5*(e(1) + e(2)) + 0.05*(dmv^2);

end