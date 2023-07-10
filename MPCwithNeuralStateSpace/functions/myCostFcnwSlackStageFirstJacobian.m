function [Jx, Ju, Jdmv] = myCostFcnwSlackStageFirstJacobian(stage, x, u, dmv, p)
% This function was generated by Model Predictive Control Toolbox (Version 8.1).
% 10-Jul-2023 16:12:19
%# codegen
persistent ADdata
if isempty(ADdata)
    ADdata = coder.load('myCostFcnwSlackStageFirstJacobianADdata','constants');
end
params.stage = stage;
params.p = p;
[~,J] = myCostFcnwSlackStageFirstJacobianAD([x;u;dmv],ADdata.constants,params);
Jx = J(1:1,:);
Ju = J(3,:);
Jdmv = J(4:4,:);