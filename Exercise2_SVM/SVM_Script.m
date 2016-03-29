%% read files

train = csvread('../train.csv');
test = csvread('../test.csv');

%% Train the SVM

n_class = size(unique(train(:,1)),1);

SVMModel = SVMTrain(train, n_class);

%% classify the testset

classes = classifySVM(SVMModel, test(:,2:end), n_class);


%% evaluate accuracy

accur = classes == test(:,1);
succ = sum(accur==1);
acurracy = succ/size(accur,1)


%% do some cross-validation...

