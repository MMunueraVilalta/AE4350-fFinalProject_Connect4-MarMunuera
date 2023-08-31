function [blockingColumn] = check_opponent_status(board)
%CHECK_OPPONENT_STATUS Summary of this function goes here
%   Detailed explanation goes here
blockingColumn=0


[rows, cols] = size(board);
    blockingColumn = -1;  % Default value if no blocking move is found
    
    for col = 1:cols
        % Find the first empty row in the column
        row = find(board(:, col) == 0, 1, 'last');
        
        if isempty(row)
            continue;  % Column is full, move to the next column
        end
        
        % Check for potential horizontal wins for the opponent
        if col <= cols - 2
            if sum(board(row, col:col+2) == 9) == 3
                blockingColumn = col+3;
                return;
            end
        end
        
        % Check for potential vertical wins for the opponent
        if row <= rows - 2
            if sum(board(row:row+2, col) == 9) == 3
                blockingColumn = col;
                return;
            end
        end
        
        % Check for potential diagonal wins (down-right) for the opponent
        if col <= cols - 2 && row <= rows - 2
            if sum(diag(board(row:row+2, col:col+2)) == 9) == 3
                blockingColumn = col+3;
                return;
            end
        end
        
        % Check for potential diagonal wins (down-left) for the opponent
        if col >= 3 && row <= rows - 2
            if sum(diag(flipud(board(row:row+2, col-2:col))) == 9) == 3
                blockingColumn = col-2;
                return;
            end
        end
    end
end

