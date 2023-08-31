function [bestMove, eval] = minimaxAlphaBeta(board, depth, alpha, beta, maximizingPlayer)
%% By Mar Munuera - last updated 30/08/2023
%MINIMAX_MAR Implementation of the minimax algorithm

    copy_board=board;
    
    if depth == 0 || game_is_over(copy_board)

        if game_is_over(copy_board)
            win_player = checkWin(board, 1);
            win_computer = checkWin(board, 9);

            if win_player==1
                eval=1000;

            elseif win_computer==1
                eval=-1000;

            else
                eval=0;
            end

            bestMove = -1;

            return;

        else
            bestMove = -1;
            eval= evaluate_board3(copy_board, 9);

            return;
        end

    end
    
    if maximizingPlayer % maximizing player - player 1
        
        maxEval = -inf;
        validMovesColumns = find(copy_board(6, :) == 0);
        
        for column = validMovesColumns 

%             disp("COLUMN:")
%             disp(column)
            new_board = make_move_minimax(copy_board, column, 1);
            [col, eval] = minimaxAlphaBeta(new_board, depth - 1, alpha, beta, false);
            
%             disp("FINAL SCORE:")
%             disp(eval)

            if eval > maxEval
                maxEval = eval;
                bestMove = column;
            end

            alpha = max(alpha, maxEval);
            
            if alpha >= beta
                break;
            end
        end
        
    else % minimizing player - player computer 9
        minEval = inf;
        validMovesColumns = find(copy_board(6, :) == 0);
        
        for column = validMovesColumns
            new_board = make_move_minimax(copy_board, column, 9);
            [col, eval]  = minimaxAlphaBeta(new_board, depth - 1, alpha, beta, true);
            
            if eval < minEval
                minEval = eval;
                bestMove = column;
            end

            beta = min(beta, minEval);
            
            if beta <= alpha
                break;
            end

        end

    end

end

