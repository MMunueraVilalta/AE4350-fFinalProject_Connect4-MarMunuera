function [game_over] = game_is_over(board)
%% By Mar Munuera - last updated 30/08/2023
%GAME_IS_OVER Summary of this function goes here
%   Return true is the game is over or return false if there are still
%   moves to be made.

game_over=false;

% check if player has won
win_player = checkWin(board, 1);
% check if computer has won
win_computer = checkWin(board, 9);

if (win_player==1) || (win_computer==1)
    game_over=true;
else
    board_not_full= check_BoardNOTFull(board);
    if board_not_full == false
        game_over=true;
    end
end

end

