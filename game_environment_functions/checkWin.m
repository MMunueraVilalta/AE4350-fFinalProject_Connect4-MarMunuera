% Function to check if a player has won
function win = checkWin(board, val)
%% By Mar Munuera - last updated 30/08/2023
%CHECK_WIN Summary of this function goes here
% if win = 1 --> Win
% if win = 0 --> No win

    win=0;
    
    % CHECK FOR HORIZONTAL WIN
    
    for row=1:6
        for col = 1:4
            if (board(row, col) == val) & (board(row, col+1) == val) &  (board(row, col+2) == val) &(board(row, col+3) == val) 
                win=1;
            end
        end
    end
    
    % CHECK FOR VERTICAL WIN
    
    if win==0
        for col = 1:7
            for row = 1:3
                if (board(row, col) == val) & (board(row+1, col) == val) &  (board(row+2, col) == val) & (board(row+3, col) == val) 
                    win=1;
                end
            end
        end
    end

    % CHECK FOR DIAGONAL WIN (increasing direction)
    for col = 1:4
        for row = 1:3
            if board(row, col) == val && board(row+1, col+1) == val && board(row+2, col+2) == val && board(row+3, col+3) == val
                win = 1;
                return; % No need to continue checking if a win is found
            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (decreasing direction)
    for col = 1:4
        for row = 4:6
            if board(row, col) == val && board(row-1, col+1) == val && board(row-2, col+2) == val && board(row-3, col+3) == val
                win = 1;
                return; % No need to continue checking if a win is found
            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (increasing direction, other diagonal)
    for col = 4:7
        for row = 1:3
            if board(row, col) == val && board(row+1, col-1) == val && board(row+2, col-2) == val && board(row+3, col-3) == val
                win = 1;
                return; % No need to continue checking if a win is found
            end
        end
    end
    
    % CHECK FOR DIAGONAL WIN (decreasing direction, other diagonal)
    for col = 4:7
        for row = 4:6
            if board(row, col) == val && board(row-1, col-1) == val && board(row-2, col-2) == val && board(row-3, col-3) == val
                win = 1;
                return; % No need to continue checking if a win is found
            end
        end
    end
end