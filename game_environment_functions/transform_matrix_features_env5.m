function [adaptedMatrix ] = transform_matrix_features_env5(board)
%TRANSFORM_MATRIX_FEATURES_ENV5 convert 1 to 11 when 3 together are
%detected and do the same for 9 to 99


    [rows, cols] = size(board);
    adaptedMatrix = board;

    for row = 1:rows
        for col = 1:cols
            value = board(row, col);

            % Check horizontal alignment for value 1
            if col <= cols - 2 && all(board(row, col:col+2) == 1)
                adaptedMatrix(row, col:col+2) = 11;
            end
            
            % Check horizontal alignment for value 9
            if col <= cols - 2 && all(board(row, col:col+2) == 9)
                adaptedMatrix(row, col:col+2) = 99;
            end

            % Check vertical alignment for value 1
            if row <= rows - 2 && all(board(row:row+2, col) == 1)
                adaptedMatrix(row:row+2, col) = 11;
            end
            
            % Check vertical alignment for value 9
            if row <= rows - 2 && all(board(row:row+2, col) == 9)
                adaptedMatrix(row:row+2, col) = 99;
            end
            
        end
    end

        % CHECK FOR DIAGONAL WIN (increasing direction)
    for col = 1:5
        for row = 1:4
            if board(row, col) == 1 && board(row+1, col+1) == 1 && board(row+2, col+2) == 1
                adaptedMatrix(row, col) = 11; 
                adaptedMatrix(row+1, col+1) = 11;
                adaptedMatrix(row+2, col+2) = 11;
            elseif board(row, col) == 9 && board(row+1, col+1) == 9 && board(row+2, col+2) == 9
                adaptedMatrix(row, col) = 99; 
                adaptedMatrix(row+1, col+1) = 99;
                adaptedMatrix(row+2, col+2) = 99;
            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (decreasing direction)
    for col = 1:5
        for row = 3:6
            if board(row, col) == 1 && board(row-1, col+1) == 1 && board(row-2, col+2) == 1
                adaptedMatrix(row, col) = 11;
                adaptedMatrix(row-1, col+1) = 11;
                adaptedMatrix(row-2, col+2) = 11;
            elseif board(row, col) == 9 && board(row-1, col+1) == 9 && board(row-2, col+2) == 9
                adaptedMatrix(row, col) = 99;
                adaptedMatrix(row-1, col+1) = 99;
                adaptedMatrix(row-2, col+2) = 99;

            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (increasing direction, other diagonal)
    for col = 3:7
        for row = 1:4
            if board(row, col) == 1 && board(row+1, col-1) == 1 && board(row+2, col-2) == 1 
                adaptedMatrix(row, col) = 11;
                adaptedMatrix(row+1, col-1) = 11;
                adaptedMatrix(row+2, col-2) = 11;
            elseif board(row, col) == 9 && board(row+1, col-1) == 9 && board(row+2, col-2) == 9 
                adaptedMatrix(row, col) = 99;
                adaptedMatrix(row+1, col-1) = 99;
                adaptedMatrix(row+2, col-2) = 99;
            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (decreasing direction, other diagonal)
    for col = 3:7
        for row = 3:6
            if board(row, col) == 1 && board(row-1, col-1) == 1 && board(row-2, col-2) == 1
                adaptedMatrix(row, col) = 11;
                adaptedMatrix(row-1, col-1) = 11;
                adaptedMatrix(row-2, col-2) = 11;
            elseif board(row, col) == 9 && board(row-1, col-1) == 9 && board(row-2, col-2) == 9
                adaptedMatrix(row, col) = 99;
                adaptedMatrix(row-1, col-1) = 99;
                adaptedMatrix(row-2, col-2) = 99;
            end
        end
    end
end

