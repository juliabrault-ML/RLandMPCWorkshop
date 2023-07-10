function J = myCostFcnwSlackStageFirst(stage, x, u, dmv, pv)

    J = 1e4*pv*u(2) + 0.05*(dmv^2);

end