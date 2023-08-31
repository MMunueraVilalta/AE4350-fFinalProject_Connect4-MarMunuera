function [availabilityVector ] = transform_matrix_features_env6(board)
%TRANSFORM_MATRIX_FEATURES_ENV5 Summary of this function goes here
%   Detailed explanation goes here

[rows, cols] = size(board);
availabilityVector = zeros(1, cols); % Initialize with zeros

for col = 1:cols
    if board(6, col) == 0
        availabilityVector(col) = 10; % Column available
    else
        availabilityVector(col) = -10; % Column full
    end
end

end

