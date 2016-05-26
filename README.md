# pattern-recognition-16m
Material for the pattern recognition lecture at University of Fribourg.
# Keyword Spotting
The folder `Exercise3_KWS/data/` contains the provided data from the [linked git repository](https://github.com/lunactic/PatRec16_KWS_Data). The folders 
- `ground-truth/`
- `images/`
- `task/`

should be placed there. The `preprocessing` script will generate a file `dataset.mat` that contains a struct to describe the data:

    dataset = 

        pageNo: array containing the page number for each sample
        lineNo: array containing the line number for each sample
        wordNo: array containing the word number for each sample
        timeseries: array containing a normalized time series of feature vectors for each sample
        mu: the mean vector used to normalize the time series
        sigma: std used to normalize the time series

Running KWS_Script.m will
- do the preprocessing
- partition the dataset into training- and validation sets
- search for a (hardcoded) keyword in the validation set by computing for each word in the validation set the DTW distance to the first image of the keyword in the training set. This function returns the indices of the n spotted words with smallest distance, where n can be specified in the arguments. These indices are stored in vector 'foundwords' and sorted according to smallest distance.
- output the keyword and the transcriptions of the n detected words
- compute precision, recall and auc

KWS_Script_Test.m uses the test data and produces the output file.
- do the preprocessing
- partition the dataset into training- and test sets
- get the keywords from `Exercise3_KWS/data/task/keywords.txt` (note: the file must only contain the keyword descriptions and no additional fileIDs)
- compute DTW-distances for each word in the test data to each keyword and write them to a file

#MNIST - SVM
Running SVM_Script.m classifies the entries in ../test.csv using ../train.csv as training data.
The assigned labels are stored in vector 'classes' and the accuracy of the classification gets output.

#Signature Verification
Running SV_Script.m will:
- read in the signatures stored in 'Exercise4_SV/data/entollment'
- read in the signatures stored in 'Exercise4_SV/data/verification'
- read in the ground truth stored in 'Exercise4_SV/data/verification-gt.txt'
- estimate a threshold for classification of individual signatures
- compute the dissimilarities for each verification-signature to the enrollment-signatures (stored in vector 'dissimilarities') and classify each signature using the estimated threshold (assigned classes stored in vector 'labels')
- evaluation (only if groundtruth file available): compute mean average-precision of the computed dissimilarities and output this value
- output the dissimilarities to a file