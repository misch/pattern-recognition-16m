# pattern-recognition-16m
Material for the pattern recognition lecture at University of Fribourg.
# data
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