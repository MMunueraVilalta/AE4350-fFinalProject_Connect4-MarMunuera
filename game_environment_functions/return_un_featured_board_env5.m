function [transformedBoard] = return_un_featured_board_env5(inputBoard)
%RETURN_UN_FEATURED_BOARD_ENV5 Summary of this function goes here
%   Detailed explanation goes here
    transformedBoard = inputBoard;
    
    % Replace 11 with 1
    transformedBoard(transformedBoard == 11) = 1;
    
    % Replace 99 with 9
    transformedBoard(transformedBoard == 99) = 9;
end

