function [new_board] = make_move_minimax(board,column, player_val)
%MAKE_MOVE_MINIMAX Summary of this function goes here
%   Detailed explanation goes here

    % Make a move on the board for the specified player
    new_board = board;

    row = getRow(new_board, column);

    new_board(row, column) = player_val;

end

