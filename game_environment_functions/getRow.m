function [row] = getRow(board, column)
%% By Mar Munuera - last updated 30/08/2023
%GET_ROW 
%   This function returs the row where the new piece can be placed.
%   If no rows are available: -1

% disp("column test:")
% disp(column)


column=round(column);
column=int16(column);


% disp(board)
% disp(column)
% disp(board(1,column))

if board(1,column)==0
    row=1;
elseif board(2,column)==0
    row=2;
elseif board(3, column)==0
    row=3;
elseif board(4,column)==0
    row=4;
elseif board(5, column)==0
    row=5;
elseif board(6,column)==0
    row=6;
else
    row=-1;
end
end

