function [ classes ] = classifyMLP( mlp, data )
%CLASSIFYMLP takes a trained patternnet and some data as input and returns
%the likely classes for the data.
% mlp: a trained patternnet
% data: a MxN matrix where M = #samples, N = #features

    classes = mlp(data');
    
    [max_score,classes] = max(classes,[],2);
    classes = classes'-1;
end

