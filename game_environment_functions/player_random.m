function [column,row] = player_random(Board)
%% By Mar Munuera - last updated 30/08/2023
%PLAYER_RANDOM get play

column= round(6*rand()+1);
row = getRow(Board, column);
while row==-1
    column= round(6*rand()+1);
    row = getRow(Board, column);
end

end

