First Team Task (SVM)

General remarks:
- matlab function "fitcsvm" used for the svm-classifier
- one-vs-all technique to allow multiclass classification
- Matlab function "cvpartition" used for 5-fold cross validation
- Cross validation tries two different kernels (linear and rbf) and 
  six different values for C (1,2,4,10,100,1000) and returns the 
  combination that performed best (takes around 4 hours on notebook).
- Parameter gamma is determined automatically by fitcsvm 
- average accuracies during cross validation written to file "cvAccuracy"
- accuracy on the test set with best parameter C outputted in matlab

Average accuracy during cross validation:
RBF kernel
C=1: 0.97378
C=2: 0.97367
C=4: 0.97352
C=10: 0.97367
C=100: 0.97363
C=1000: 0.97363

Linear kernel
C=1: 0.90981
C=2: 0.91011
C=4: 0.90981
C=10: 0.90996
C=100: 0.90981
C=1000: 0.91

Accuracy on the test set with best parameter C:
C=1: 0.9775