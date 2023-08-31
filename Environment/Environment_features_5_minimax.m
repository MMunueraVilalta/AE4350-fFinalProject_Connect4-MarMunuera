classdef Environment_features_5_minimax < rl.env.MATLABEnvironment
    % ENVIRONMENT simulates a Connect4 game in MATLAB where the
    % reinforcement learning agent plays against the minimax algorithm player.
    
    %% Properties (set properties' attributes accordingly)
    properties
        
        % Set the rewards to be obtained
        RewardForWinning=1;
        PenaltyForLoosing=-1;
        PenaltyFullColumn=-0.5;
        PenaltyForTie=0;
        NoWin=0;
        RewardFeasibleAction=0.05;

        computer_wins = "RL wins !"
        player_wins = "Minimax wins !"
        tie_no_wins = "Tie !"

        % Flatten the Board matrix into a 1-dimensional array (State vector)
        State = zeros([42 1]);

        randomness=0.05;

    end
    
    properties (Access = private, Transient)
        % Visualizer object for the game
        Visualizer = []
    end
    
    properties(Access = protected)
        % Initialize internal flag to indicate episode termination
        IsDone = false        
    end

    %% Necessary Methods
    methods              
        function this = Environment_features_5_minimax()
            % This method sets the observation information and action
            % information of the environment.

            % Initialize Observation settings
            ObservationInfo = rlNumericSpec([42, 1]);
            ObservationInfo.Name = 'States of the Board';

            % Set the action info to be discrete with the specified values
            % Define the discrete actions
            numActions = 7;
            actionValues = 1:numActions;
            ActionInfo = rlFiniteSetSpec(actionValues);
            ActionInfo.Name = 'Action';
            ActionInfo.Description = 'Columns that can be chosen';
            
            % The following line implements built-in functions of RL env
            this = this@rl.env.MATLABEnvironment(ObservationInfo,ActionInfo);

        end

%          STEPS START WITH RL
        function [Observation,Reward,IsDone,LoggedSignals] = step(this,Action) 

            % Apply system dynamics and simulates the environment with the 
            % given action for one step.
            % This function first applies the action of the RL agent and
            % later applies the action of the player, in this case the
            % minimax algorithm.

            LoggedSignals = [];

            transformedBoard = return_un_featured_board_env5(this.State);

            % Unpack state vector
            Board = reshape(transformedBoard, 6,7);

            IsDone = false;

            % Get the given action and update the board
            column = round(Action);
            row = getRow(Board, column);

            % If the action was not feasible: look for another option 
            if row==-1
                Reward = this.PenaltyFullColumn ;  % Computer wins
                IsDone = true;

            else
                % Place the computers piece on the Board.
                Board(row, column) = 9; 

                % Check if the board is not full
                BoardNotFull = check_BoardNOTFull(Board);

                % Check if the computer has won
                win = checkWin(Board, 9);

                % If computer has won, place reward and set the message in the
                % visualizer
                if win==1 
                    Reward = this.RewardForWinning + this.RewardFeasibleAction;  % Computer wins
                    IsDone = true;
                    % this.Visualizer.setOutcomeMessage(this.computer_wins); % out for parallelcomputing

                % If the computer has not won, check if there is a tie and set
                % the message in the visualizer.
                elseif BoardNotFull==false
                    Reward = this.PenaltyForTie + this.RewardFeasibleAction;
                    IsDone = true;
                    % this.Visualizer.setOutcomeMessage(this.tie_no_wins); % out for parallelcomputing

                % Continue with the step if the computer has not won and the
                % board is not full yet.
                else

                    % Use the minimax algorithm to select the oponent's piece

                    if rand()>this.randomness
                        column = minimaxAlphaBeta(Board, 1, -inf, inf, true);
                        row = getRow(Board, column);
                    else
                        % Use the random algorithm to select the oponent's piece
                        [column, row] = player_random(Board);
                    end

                    % Place the players piece on the board
                    Board(row, column) = 1;

                    % Check if the board is full
                    BoardNotFull = check_BoardNOTFull(Board);

                    win = checkWin(Board, 1);

                    % Check if the player has won and if so, place a penalty
                    % for loosing and setting a message on the visualizer.
                    if win
                        Reward = this.PenaltyForLoosing + this.RewardFeasibleAction; 
                        IsDone = true;
                        % this.Visualizer.setOutcomeMessage(this.player_wins); % out for parallelcomputing

                    % If the player has not won, check if there is a tie and set
                    % the message in the visualizer.
                    elseif BoardNotFull==false
                        Reward = this.PenaltyForTie + this.RewardFeasibleAction;
                        IsDone = true;
                        % this.Visualizer.setOutcomeMessage(this.tie_no_wins);
                        % % out for parallelcomputing

                    % If none of the players has won and the board is not full,
                    % then no reward is given (Reward=0), and the next step can
                    % be performed
                    else
                        IsDone = false;
                        % can keep going
                        Reward=this.NoWin + this.RewardFeasibleAction; 

                        % this.Visualizer.setOutcomeMessage(''); % out for
                        % parallel computing
                    end
                end


            end

            Board_with_features  = transform_matrix_features_env5(Board);

            % Flatten the Board matrix into a 1-dimensional array (State vector)
            Observation = reshape(Board_with_features, 42, 1);

            % Update system states
            this.State = Observation;

            % Check terminal condition
            this.IsDone = IsDone;

            % Use notifyEnvUpdated to signal that the 
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end


        function InitialObservation = reset(this)
            % Reset environment to initial state and output initial observation
            Board=zeros([6, 7]);

            % Flatten the Board matrix into a 1-dimensional array (State vector)
            Observation = reshape(Board, 42,1);

            LoggedSignal.State = Observation;

            InitialObservation = LoggedSignal.State;
            this.State = InitialObservation;
            
            % Use notifyEnvUpdated to signal that the 
            % environment has been updated (e.g. to update visualization)
            notifyEnvUpdated(this);
        end
        
       
    end
    %% Optional Methods (set methods' attributes accordingly)
    methods               

        function varargout = plot(this)
            % Visualization method

            if isempty(this.Visualizer) || ~isvalid(this.Visualizer)
                this.Visualizer = Visualizer(this);
            else
                bringToFront(this.Visualizer);
            end
            if nargout
                varargout{1} = this.Visualizer;
            end
            % Update the visualization
            envUpdatedCallback(this)
        end

        % Properties validation through set methods
        function set.State(this,state)
            validateattributes(state,{'numeric'},{'finite','real','vector','numel',42},'','State');
            this.State = (state(:)); % double(state(:));
            notifyEnvUpdated(this);
        end

    end
    
    methods (Access = protected)
        % Update visualization everytime the environment is updated 
        % (notifyEnvUpdated is called)
        function envUpdatedCallback(this)
            
        end
    end
end
