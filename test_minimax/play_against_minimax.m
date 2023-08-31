%% Bio-inspired Intelligence and learning for Aerospace Engineering 
% CONNECT 4 with RL by MAR MUNUERA VILALTA 

clc;
clear all
close all

%%
computer_wins=0;
player_wins=0;

for i=1:1
    % h, x --> horizontal
    % v, y --> vertical
    
    hx0 = [0, 7]; hy0 = [0, 0]; % horizontal line 0
    hx1 = [0, 7]; hy1 = [1, 1]; % horizontal line 1
    hx2 = [0, 7]; hy2 = [2, 2]; % horizontal line 2
    hx3 = [0, 7]; hy3 = [3, 3]; % horizontal line 3
    hx4 = [0, 7]; hy4 = [4, 4]; % horizontal line 4
    hx5 = [0, 7]; hy5 = [5, 5]; % horizontal line 5
    hx6 = [0, 7]; hy6 = [6, 6]; % horizontal line 6
    vx0 = [0, 0]; vy0 = [0, 6]; % vertical line 0
    vx1 = [1, 1]; vy1 = [0, 6]; % vertical line 1
    vx2 = [2, 2]; vy2 = [0, 6]; % vertical line 2
    vx3 = [3, 3]; vy3 = [0, 6]; % vertical line 3
    vx4 = [4, 4]; vy4 = [0, 6]; % vertical line 4
    vx5 = [5, 5]; vy5 = [0, 6]; % vertical line 5
    vx6 = [6, 6]; vy6 = [0, 6]; % vertical line 6
    vx7 = [7, 7]; vy7 = [0, 6]; % vertical line 7
    clf
    
    % PLOT THE GRID - EMPTY
    
    plot(hx0, hy0, 'k', hx1, hy1, 'k', hx2, hy2, 'k', hx3, hy3, 'k', hx4, hy4, 'k', hx5, hy5, 'k', hx6, hy6, 'k', ...
        vx0, vy0, 'k', vx1, vy1, 'k', vx2, vy2, 'k', vx3, vy3, 'k', vx4, vy4, 'k', vx5, vy5, 'k', vx6, vy6, 'k', ...
        vx7, vy7, 'k')
    axis off, axis square, ...
        set(gcf, 'color', [1 1 1])
    
    % PAUSE THE PLOT
    pause(2)
    
    play_num=0;
    win=0;
    board = zeros(6,7);
    
    while (play_num<42) && (win==0)
    
        % HUMAN TURN  - 9

        [x, y] = ginput(1);
        [move_col,move_row, column, row] = get_piece_player(x,board);
     
        board(row, column)=9;
        disp(board)
        move = text(move_col, move_row, 'X', ...
            'fontsize', 20, 'horizontalalignment', 'center');
        set(move, 'color', 'm')
        
        win = checkWin(board, 9);
        if win==1
            ti = title('Human wins!');
            set(ti, 'color', 'm')
            set(ti,'FontWeight','bold')
            set(ti,'FontSize',19)
            player_wins=player_wins+1;
        end

        play_num=play_num +1;
    
        if win==0
    
            % MINIMAX TURN - 1
    
            [column, eval] = minimaxAlphaBeta(board, 1, -inf, inf, true);
            row = getRow(board, column);
        
            disp(column)
            board(row, column)=1;
            disp(board)

            move = text(column-1+0.5, row-1+0.5, 'O', ...
                'fontsize', 20, 'horizontalalignment', 'center');
            set(move, 'color', 'c')
        
            win = checkWin(board, 1);
            if win==1
                ti = title('Computer wins!');
                set(ti, 'color', 'c')
                set(ti,'FontWeight','bold')
                set(ti,'FontSize',19)
                computer_wins=computer_wins+1;
            end
    
        end
    
    end

    disp("Iteration")
    disp(i)
end

disp(" SUMMARY OF RESULTS :")
disp(" -- player wins :")
disp(player_wins)
disp(" -- computer wins :")
disp(computer_wins)
