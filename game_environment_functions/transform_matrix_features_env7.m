function [availabilityVector ] = transform_matrix_features_env7(board)
%% By Mar Munuera - last updated 30/08/2023
%TRANSFORM_MATRIX_FEATURES_ENV7 Return 10 in feasible columns and -10 in
%non feasible columns and +100 in advantageous moves

[rows, cols] = size(board);
availabilityVector = zeros(1, cols); % Initialize with zeros

for col = 1:cols
    if board(6, col) == 0
        availabilityVector(col) = 10; % Column available
    else
        availabilityVector(col) = -10; % Column full
    end
end

% check for vertical 2 in a row:
for col=1:cols
    my_row=getRow(board, col);
    if my_row ~=-1
        if my_row>2
            if board(my_row-1, col)==board(my_row-2, col) && board(my_row-2, col)~=0
                availabilityVector(col)=100;
            end
        end
    end
end

% check for horizontal 2 in a row:
for col=1:(cols-2)
    my_row=getRow(board, col);
    if my_row ~=-1
        if board(my_row, col+1)==board(my_row, col+2) && board(my_row, col+2)~=0
            availabilityVector(col)=100;
        end
    end

end

% check for digonal 2 in a row:
for col=1:cols
    my_row=getRow(board, col);
    if my_row~=-1
        if my_row<5
            if col<6
                if board(my_row+1, col+1)==board(my_row+2, col+2) && board(my_row+2, col+2)~=0
                    availabilityVector(col)=100;
                end
            elseif col>2
                if board(my_row+1, col-1)==board(my_row+2, col-2) && board(my_row+2, col-2)~=0
                    availabilityVector(col)=100;
                end
            end
        end
        if my_row>2
            if col<6
                if board(my_row-1, col+1)==board(my_row-2, col+2) && board(my_row-2, col+2)~=0
                    availabilityVector(col)=100;
                end
            elseif col>2
                if board(my_row-1, col-1)==board(my_row-2, col-2) && board(my_row-2, col-2)~=0
                    availabilityVector(col)=100;
                end
            end
            
        end
    end

end

end

