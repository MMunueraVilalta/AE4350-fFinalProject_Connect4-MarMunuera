function [move_col,move_row, col, row] = get_piece_player(x,board)
%% By Mar Munuera - last updated 30/08/2023
%GET_PIECE_PLAYER 

if x<1
    col =1;
    move_col=0.5;
elseif x<2
    col=2;
    move_col=1.5;
elseif x<3
    col=3;
    move_col=2.5;
elseif x<4
    col=4;
    move_col=3.5;
elseif x<5
    col=5;
    move_col=4.5;
elseif x<6
    col=6;
    move_col=5.5;
elseif x<7
    col=7;
    move_col=6.5;
end

row = getRow(board, col);
move_row=row-0.5;
end

