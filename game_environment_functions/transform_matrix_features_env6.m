function [availabilityVector ] = transform_matrix_features_env6(board)
%% By Mar Munuera - last updated 30/08/2023
%TRANSFORM_MATRIX_FEATURES_ENV6 Return 10 in feasible columns and -10 in
%non feasible columns

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

