function [score] = evaluate_board2(board, player_or_computer)
%EVALUATE_BOARD Summary of this function goes here
%   Detailed explanation goes here

    score = 0;
    piece= player_or_computer;

    % Constants
    ROW_COUNT = 6; %size(board, 1);
    COLUMN_COUNT = 7; % size(board, 2);
    WINDOW_LENGTH = 4;

    % Score center column
    center_array = board(:, floor(COLUMN_COUNT / 2));
    center_count = sum(center_array == piece);
    score = score + center_count * 3;

    % Score Horizontal
    for r = 1:ROW_COUNT
        row_array = board(r, :);
        for c = 1:COLUMN_COUNT - 3
            window = row_array(c:c+WINDOW_LENGTH-1);
            score = score + evaluate_window(window, piece);
        end
    end

    % Score Vertical
    for c = 1:COLUMN_COUNT
        col_array = board(:, c);
        for r = 1:ROW_COUNT - 3
            window = col_array(r:r+WINDOW_LENGTH-1);
            score = score + evaluate_window(window, piece);
        end
    end

    % Score positive sloped diagonal
    for r = 1:ROW_COUNT - 3
        for c = 1:COLUMN_COUNT - 3
            window = diag(flipud(board(r:r+WINDOW_LENGTH-1, c:c+WINDOW_LENGTH-1)));
            score = score + evaluate_window(window, piece);
        end
    end

    for r = 1:ROW_COUNT - 3
        for c = 1:COLUMN_COUNT - 3
            window = diag(board(r+WINDOW_LENGTH-1:-1:r, c:c+WINDOW_LENGTH-1));
            score = score + evaluate_window(window, piece);
        end
    end


end