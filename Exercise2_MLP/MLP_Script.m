%% read files
train = csvread('../train.csv');
trainingData = train(:,2:end);
trainingLabels = train(:,1);
clear train;

test = csvread('../test.csv');
testData = test(:,2:end);
testLabels = test(:,1);
clear test;
%%
allData = [trainingData;testData];
allLabels = [trainingLabels; testLabels];

clear trainingData trainingLabels
clear testData testLabels

%% Crossvalidation

setSize = size(allLabels,1);
results = zeros(7,10,1);
quadrantSize = floor(setSize/4);
for numNeurons = 10:20:100 %4200
	numNeurons
	nextLine = zeros(7,10);
	for learningRate10 = 2:2:10
		learningRate10
		nextLine(1,learningRate10) = numNeurons;
		nextLine(2,learningRate10) = learningRate10/10;
		
		parfor cross = 1:4
			cross
			mask = true(setSize,1);
			mask((cross-1)*quadrantSize+1:cross*quadrantSize) = 0;
			data = allData(mask,:);
			labels = allLabels(mask);
			
			testdata = allData(~mask,:);
			testlabels = allLabels (~mask);
			mlp = trainMLP(data, labels, numNeurons, learningRate);
			classes = classifyMLP(mlp, testdata);
			accuracy = sum(classes == testlabels)/length(testlabels);
		
			nextLine(cross+2, learningRate10) = accuracy;
		end
		nextLine(7,learningRate10)= mean(nextLine(3:6,learningRate10));
	end
	nextLine
	results= cat(3,results,nextLine);
	size(results)
end

% write result to file

resultReshaped = reshape(results,7,10*size(results,3))';
csvwrite('result.csv',resultReshaped);

%% get best result parameters
[~,I] = max(resultReshaped(:,7),[],1)


%% train MPL with 1 hidden layer with the best params
mlp = trainMLP(allData, allLabels, resultReshaped(I,1), resultReshaped(I,2));

%% classify the testset
classes = classifyMLP(mlp, allData);
errors = gsubtract(allLabels,classes);

%% evaluate accuracy
accuracy = sum(classes == allLabels)/length(allLabels)
