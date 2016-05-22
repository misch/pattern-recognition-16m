function [ dist ] = dtwDistance( s1, s2 )
%DTW Compute dissimilarity between two sequences of feature vectors s1 
%    and s2 using dynamic time warping (DTW)
%    Input: 
%       s1: m1xn matrix with m1 the number of sliding windows and n the
%           number of features
%       s2: m2xn matrix with m2 the number of sliding windows and n the
%           number of features
%    Return: 
%       dist: distance/dissimilarity between s1 and s2

% Allocate dtw-matrix to compute dtw with dynamic programming
m1 = size(s1,1)+1;
m2 = size(s2,1)+1;
DTW = zeros(m1,m2);
w = abs(m1-m2);

% Initialize first row and column of dtw-matrix
DTW(:,:) = inf;
DTW(1,1) = 0;

% Compute remaining entries of the dtw-matrix
for i = 2:m1
    for j = max(2,i-w):min(m2,i+w)
        cost = norm(s1(i-1,:)-s2(j-1,:));
        DTW(i,j) = cost + min([DTW(i-1,j),DTW(i,j-1),DTW(i-1,j-1)]);
    end
end

% Entry at (m1+1,m2+1) is the dtw-distance between s1 and s2
dist = DTW(end);
end