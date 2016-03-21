%% read files

train = csvread('../train.csv');
test = csvread('../test.csv');

%% train MPL with 1 hidden layer

mlp = trainMLP(train);

%% classify the testset

classes = classifyMLP(mlp, test);


%% evaluate accuracy

accur = classes == test(:,1);
succ = sum(accur==1);
acurracy = succ/size(accur)

%%  tweak networks...