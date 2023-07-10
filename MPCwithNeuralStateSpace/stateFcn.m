function x1 = stateFcn(x,u)
%% auto-generated state function of neural state space system
%# codegen
persistent StateNetwork
MATname = 'stateFcnData';
if isempty(StateNetwork)
    StateNetwork = coder.load(MATname);
end
out = [x;u];
% hidden layer #1
out = StateNetwork.fc1.Weights*out + StateNetwork.fc1.Bias;
out = deep.internal.coder.tanh(out);
% hidden layer #2
out = StateNetwork.fc2.Weights*out + StateNetwork.fc2.Bias;
out = deep.internal.coder.tanh(out);
% output layer
dx = StateNetwork.output.Weights*out + StateNetwork.output.Bias;
x1 = x + dx;
