function [new_board] = make_move_minimax(board,column, player_val)
%% By Mar Munuera - last updated 30/08/2023
%MAKE_MOVE_MINIMAX  

    % Make a move on the board for the specified player
    new_board = board;

    row = getRow(new_board, column);

    new_board(row, column) = player_val;

end

