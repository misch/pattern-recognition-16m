%% read files

train = csvread('../train.csv');
test = csvread('../test.csv');

%% Find optimal parameters by cross validation

n_class = size(unique(train(:,1)),1);

%[optC, optKernel, optCAcc] = crossValidateSVM(train, n_class, 5);
optC = 1;
optKernel = 'rbf';

%% Train the SVM

SVMModel = SVMTrain(train, n_class, optC, optKernel);

%% classify the testset

classes = classifySVM(SVMModel, test(:,2:end), n_class);


%% evaluate accuracy

accur = classes == test(:,1);
succ = sum(accur==1);
accuracy = succ/size(accur,1)
