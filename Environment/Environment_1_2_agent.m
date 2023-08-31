classdef Environment_1_2_agent < rl.env.MATLABEnvironment
    %% By Mar Munuera - last updated 30/08/2023
    % ENVIRONMENT simulates a Connect4 game in MATLAB where the
    % reinforcement learning agent plays against the minimax algorithm player.
    
    %% Properties (set properties' attributes accordingly)
    properties
        
        % Set the rewards to be obtained
        RewardForWinning=1;
        PenaltyForLoosing=-1;
        PenaltyForTie=0;
        NoWin=0;
        PenaltyFullColumn=-0.1;
        RewardAvailableColumn=0;

        % Flatten the Board matrix into a 1-dimensional array (State vector)
        State = zeros([42 1]);

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
        function this = Environment_1_2_agent()
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


        function [Observation,Reward,IsDone,LoggedSignals] = step(this,Action,board_val) 

            action_choice=this.RewardAvailableColumn;

            % Apply system dynamics and simulates the environment with the 
            % given action for one step.
            % This function first applies the action of the RL agent and
            % later applies the action of the player, in this case the
            % minimax algorithm.
            
            LoggedSignals = [];
            
            % Unpack state vector
            Board = reshape(this.State, 6,7);

            IsDone = false;

            % Get the given action and update the board
            column = round(Action);
            row = getRow(Board, column);
            
            % If the action was not feasible: look for another option 
            if row==-1
                action_choice=this.PenaltyFullColumn;
            end

            while row==-1
                column= round(6*rand()+1);
                row = getRow(Board, column);
            end

            % Place the player piece on the Board.
            Board(row, column) = board_val; 
            
            % Check if the board is not full
            BoardNotFull = check_BoardNOTFull(Board);
            
            % Check if the player has won
            win = checkWin(Board, board_val);

            % If computer has won, place reward and set the message in the
            % visualizer
            if win==1 
                Reward = this.RewardForWinning + action_choice;  % Computer wins
                IsDone = true;
                if board_val ==1
                    win_message = "Agent 1 Wins";
                else
                    win_message = "Agent 2 Wins";
                end
                % this.Visualizer.setOutcomeMessage(win_message);

            % If the computer has not won, check if there is a tie and set
            % the message in the visualizer.
            elseif BoardNotFull==false
                Reward = this.PenaltyForTie + action_choice;
                IsDone = true;
                % this.Visualizer.setOutcomeMessage(this.tie_no_wins);
            
            % Continue with the step if the computer has not won and the
            % board is not full yet.
            else
                IsDone = false;
                % can keep going
                Reward=this.NoWin + action_choice; 
                % this.Visualizer.setOutcomeMessage('');

            end

            % Flatten the Board matrix into a 1-dimensional array (State vector)
            Observation = reshape(Board, 42, 1);

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
