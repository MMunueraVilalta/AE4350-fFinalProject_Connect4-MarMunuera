classdef Visualizer < rl.env.viz.AbstractFigureVisualizer
% Visualize a reinforcement learning environment in a figure
    
    properties (Access = private)
        OutcomeMessage = '';  % Store the outcome message
    end

    methods
        function this = Visualizer(env)

            this = this@rl.env.viz.AbstractFigureVisualizer(env);

        end

        function setOutcomeMessage(this, message)
            this.OutcomeMessage = message;
            this.updatePlot();  % Update the plot to display the message
        end
        
    end
    methods (Access = protected)

        function f = buildFigure(this)
            f = figure(...
                'Toolbar','none',...
                'Visible','on',...
                'HandleVisibility','off', ...
                'NumberTitle','off',...
                'Name','Visualizer',... 
                'MenuBar','none',...
                'CloseRequestFcn',@(~,~)delete(this));

            if ~strcmp(f.WindowStyle,'docked')
                f.Position(3:4) = [400 500];

            end

            ha = gca(f);
            ha.XLim = [0 7];
            ha.YLim = [0 6];

            hold(ha,'on');


        end

        function updatePlot(this)
            % This function sets the grid of the Board and places the
            % player and computer pieces as defined in the environment.
            
            env = this.Environment;
            f = this.Figure;
            ha = gca(f);
            cla(ha);
            rad=0.3;

            % Create the vertical lines
            line(ha, [1 1], [0 6], 'Color', 'k', 'LineWidth', 1);
            line(ha, [2 2], [0 6], 'Color', 'k', 'LineWidth', 1);
            line(ha, [3 3], [0 6], 'Color', 'k', 'LineWidth', 1);
            line(ha, [4 4], [0 6], 'Color', 'k', 'LineWidth', 1);
            line(ha, [5 5], [0 6], 'Color', 'k', 'LineWidth', 1);
            line(ha, [6 6], [0 6], 'Color', 'k', 'LineWidth', 1);

            % Create the horizontal lines
            line(ha, [0 7], [1 1], 'Color', 'k', 'LineWidth', 1);
            line(ha, [0 7], [2 2], 'Color', 'k', 'LineWidth', 1);
            line(ha, [0 7], [3 3], 'Color', 'k', 'LineWidth', 1);
            line(ha, [0 7], [4 4], 'Color', 'k', 'LineWidth', 1);
            line(ha, [0 7], [5 5], 'Color', 'k', 'LineWidth', 1);
            line(ha, [0 7], [6 6], 'Color', 'k', 'LineWidth', 1);

            state = env.State;
            
            Board = reshape(state(1:42), 6,7);

            for col=1:length(Board(1,:)) % columns
                for row=1:length(Board(:,1)) % rows

                    if Board(row,col)==1 || Board(row,col)==11 % Player 
                        rectangle(ha,'Position',[col-0.5-rad row-0.5-rad 2*rad 2*rad],'Curvature',[1 1],'FaceColor','m')

                    elseif Board(row,col)==9 || Board(row,col)==99 % computer
                        rectangle(ha,'Position',[col-0.5-rad row-0.5-rad 2*rad 2*rad],'Curvature',[1 1],'FaceColor','c')
                    end
                end
            end

            if ~isempty(this.OutcomeMessage)
                txt = sprintf(this.OutcomeMessage);
                text(ha,1,3,txt,"FontSize",24, "FontWeight","bold", "BackgroundColor", 'white' );
            end

            % Refresh rendering in figure window
            drawnow();
        end

    end
end