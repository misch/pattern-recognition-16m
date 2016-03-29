%% read files
train = csvread('../train.csv');
trainingData = train(:,2:end);
trainingLabels = train(:,1);
clear train;

test = csvread('../test.csv');
testData = test(:,2:end);
testLabels = test(:,1);
clear test;

%% train MPL with 1 hidden layer
mlp = trainMLP(trainingData,trainingLabels);

%% classify the testset
classes = classifyMLP(mlp, testData);
errors = gsubtract(testLabels,classes);

%% evaluate accuracy
accuracy = sum(classes == testLabels)/length(testLabels);