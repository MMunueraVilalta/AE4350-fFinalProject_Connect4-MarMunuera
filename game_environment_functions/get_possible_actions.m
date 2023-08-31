function [columns] = get_possible_actions(board)
%GET_POSSIBLE_ACTIONS Summary of this function goes here
%   Detailed explanation goes here

full_vect = (board(6, :) == 0);
indices_of_ones = find(input_vector == 1);
columns=indices_of_ones;

end

