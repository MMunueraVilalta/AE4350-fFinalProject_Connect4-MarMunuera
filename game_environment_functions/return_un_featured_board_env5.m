function [transformedBoard] = return_un_featured_board_env5(inputBoard)
%% By Mar Munuera - last updated 30/08/2023
%RETURN_UN_FEATURED_BOARD_ENV5 Tranform back the board

    transformedBoard = inputBoard;
    
    % Replace 11 with 1
    transformedBoard(transformedBoard == 11) = 1;
    
    % Replace 99 with 9
    transformedBoard(transformedBoard == 99) = 9;
end

