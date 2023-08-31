function [column,row] = player_random(Board)
%PLAYER_RANDOM Summary of this function goes here
%   Detailed explanation goes here

column= round(6*rand()+1);
row = getRow(Board, column);
while row==-1
    column= round(6*rand()+1);
    row = getRow(Board, column);
end

end

