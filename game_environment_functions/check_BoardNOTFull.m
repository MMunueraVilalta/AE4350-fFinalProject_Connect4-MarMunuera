function [result] = check_BoardNOTFull(Board)
%% By Mar Munuera - last updated 30/08/2023
% returns true if the board is Full
% returns false if the Board is full
res = any(Board(:) == 0);
if res == 1
    result= true;
else
    result=false;
end

