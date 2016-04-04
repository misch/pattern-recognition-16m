function [net] = trainMLP(data,labels, n_neurons, rate )
%TRAINMLP trains a patternnet using the input data and labels
% data: a MxN matrix where M = #samples, N = #features
% labels: a Mx1 vector containing ground truth class labels

    net = patternnet(n_neurons); % for more layers, give array of neuron size
    
    net.divideParam.trainRatio = 70/100;
    net.divideParam.valRatio = 15/100;
    net.divideParam.testRatio = 15/100;
	net.trainParam.lr = rate;
    
    targets = full(ind2vec(labels'+1));
    [net, tr] = train(net,data',targets);
end

