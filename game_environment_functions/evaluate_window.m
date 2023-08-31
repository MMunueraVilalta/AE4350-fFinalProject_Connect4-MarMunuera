function [window_score] = evaluate_window(window,piece)
%% By Mar Munuera - last updated 30/08/2023
%EVALUATE_WINDOW of the board for the minimax algorithm and returns the
%score
    score = 0;

    if piece ==1
        opp_piece=9;
    else
        opp_piece=1;
    end


    if sum(window == piece) == 4
        score = score + 5000;
    elseif sum(window == piece) == 3 && sum(window == 0) == 1
        score = score + 2000;
    elseif sum(window == piece) == 2 && sum(window == 0) == 2
        score = score + 2;
    end

    if sum(window == piece) == 3 && sum(window == opp_piece) == 1
        score = score + 4000;
    end

    if sum(window == opp_piece) == 4
        score = score - 2000;
    elseif sum(window == opp_piece) == 3 && sum(window == 0) == 1
        score = score - 500;
    elseif sum(window == opp_piece) == 2 && sum(window == 0) == 2
        score = score - 1;
    end

    window_score = score;
end

