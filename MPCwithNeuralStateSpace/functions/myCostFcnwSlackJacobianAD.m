function [obj, grad] = myCostFcnwSlackJacobianAD(inputVariables, extraParams, params)
%myCostFcnwSlackJacobianAD Compute objective function value and gradient
%
%   OBJ = myCostFcnwSlackJacobianAD(INPUTVARIABLES, EXTRAPARAMS, PARAMS)
%   computes the objective value OBJ at the point INPUTVARIABLES, using
%   the extra parameters in EXTRAPARAMS and parameters in PARAMS.
%
%   [OBJ, GRAD] = myCostFcnwSlackJacobianAD(INPUTVARIABLES, EXTRAPARAMS,
%   PARAMS) additionally computes the objective gradient value GRAD at the
%   current point.
%
%   Auto-generated by prob2struct on 10-Jul-2023 16:12:19

%#codegen
%#internal
%% Variable indices.
uidx = 2:3;
eidx = 5:6;
dmvidx = 4;

%% Map solver-based variables to problem-based.
u = inputVariables(uidx);
u = u(:);
e = inputVariables(eidx);
e = e(:);
dmv = inputVariables(dmvidx);

%% Extract parameters.
p = params.p;

%% Compute objective function.
arg3 = 100000;
arg5 = 10000;
arg9 = extraParams{1};
arg4 = (e(1) + e(2));
arg7 = (arg5 .* p);
arg8 = u(2);
arg10 = dmv.^2;
obj = (((arg7 .* arg8) + (arg3 .* arg4)) + (arg9 .* arg10));

if nargout > 1
    %% Compute objective gradient.
    % To call the gradient code, notify the solver by setting the
    % SpecifyObjectiveGradient option to true.
    arg18 = zeros(6, 1);
    ujac = zeros(2, 1);
    ejac = zeros(2, 1);
    dmvjac = 0;
    arg11 = 1;
    dmvjac = dmvjac + ((arg11.*arg9(:)).*2.*(dmv(:)));
    arg12 = (arg11.*arg7(:));
    arg13 = zeros(2, 1);
    arg13(2,:) = arg12;
    ujac = ujac + arg13;
    arg14 = (arg11.*arg8(:));
    arg15 = (arg11.*arg3(:));
    arg16 = zeros(2, 1);
    arg16(2,:) = arg15;
    ejac = ejac + arg16;
    arg17 = zeros(2, 1);
    arg17(1,:) = arg15;
    ejac = ejac + arg17;
    arg18(uidx,:) = ujac;
    arg18(eidx,:) = ejac;
    arg18(dmvidx,:) = dmvjac;
    grad = arg18(:);
end
end