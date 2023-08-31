function [score] = evaluate_board3(board, player_or_computer)
%% By Mar Munuera - last updated 30/08/2023
    %EVALUATE_BOARD computes the score for the minimax algorithm

    score = 0;
    piece = player_or_computer;

    % Constants
    ROW_COUNT = 6; %size(board, 1);
    COLUMN_COUNT = 7; % size(board, 2);
    WINDOW_LENGTH = 4;

    % Score center column
    center_array = board(:, 4);
    center_count = sum(center_array == piece);
    score = score + center_count * 3;

    % Score Horizontal, Vertical, and Diagonals
    for r = 1:ROW_COUNT
        for c = 1:COLUMN_COUNT
            if c <= COLUMN_COUNT - WINDOW_LENGTH + 1
                % Evaluate rows
                row_window = board(r, c:c+WINDOW_LENGTH-1);
                score = score + evaluate_window(row_window, piece);
            end
            if r <= ROW_COUNT - WINDOW_LENGTH + 1
                % Evaluate columns
                col_window = board(r:r+WINDOW_LENGTH-1, c);
                score = score + evaluate_window(col_window, piece);
            end
            if c <= COLUMN_COUNT - WINDOW_LENGTH + 1 && r <= ROW_COUNT - WINDOW_LENGTH + 1
%                 % Evaluate positive sloped diagonal
%                 pos_diag_window = diag(flipud(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1)));
%                 score = score + evaluate_window(pos_diag_window, piece);
% 
%                 % Evaluate negative sloped diagonal
%                 neg_diag_window = diag(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1));
%                 score = score + evaluate_window(neg_diag_window, piece);

                 % Evaluate positive sloped diagonal
                pos_diag_window = diag(flipud(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1)));
                score = score + evaluate_window(pos_diag_window, piece);

                % Evaluate negative sloped diagonal
                neg_diag_window = diag(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1));
                score = score + evaluate_window(neg_diag_window, piece);
                
                % Evaluate other diagonal (top-right to bottom-left)
                if c >= WINDOW_LENGTH
                    other_diag_window1 = diag(flipud(board(r:r+WINDOW_LENGTH-1, c:-1:c-WINDOW_LENGTH+1)));
                    score = score + evaluate_window(other_diag_window1, piece);
                end
                
                % Evaluate other diagonal (top-left to bottom-right)
                other_diag_window2 = diag(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1));
                score = score + evaluate_window(other_diag_window2, piece);

            end
        end
    end


    % Additional logic to prioritize blocking opponent's potential win in
    % horizontal conditions
    for r = 1:ROW_COUNT
        for c = 1:COLUMN_COUNT-4
            if board(r, c) == 0 && board(r, c+1) == piece && board(r, c+2) == piece && board(r, c+3) == 0
                if r==1 
                    
                    score = score - 10000; % Penalize this scenario heavily
                elseif board(r-1, c) ~= 0 && board(r-1, c+3) ~= 0 
                    score = score - 10000; % Penalize this scenario heavily
                else
                    % Nothing
                    score=score + 0;
                end
            end
        end
    end

%     % Additional logic to prioritize blocking opponent's potential win in
%     % diagonal conditions
%     for r = 1:ROW_COUNT -4
%         for c = 1:COLUMN_COUNT-4
%             if board(r, c) == piece && board(r+1, c+1) == piece && board(r+2, c+2) == piece && board(r+3, c+3) == 0
%                 if board(r+2, c+3) == 0
%                     score = score - 500; % Penalize this scenario heavily
%                 else
%                     % Nothing
%                     score=score + 0;
%                 end
%             end
%         end
%     end

end
