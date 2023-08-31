function [agent] = DQN_agent(obsInfo, actInfo, use_default_neural_network, standard_agent_options, options)
% AC_AGENT 

    % Define the agent
    if use_default_neural_network

        if standard_agent_options
            agent = rlDQNAgent(obsInfo,actInfo);
      
        else
            agent = rlDQNAgent(obsInfo,actInfo, options);
        end
    
    else
        disp("The DQN agent is using critic ")
        % 
        %                % CRITIC
        % % Observation path layers
        % obsPath = [featureInputLayer(prod(obsInfo.Dimension))
        %            fullyConnectedLayer(100)
        %            reluLayer
        %            fullyConnectedLayer(50)
        %            reluLayer
        %            fullyConnectedLayer(50,Name="obsout")];
        % 
        % % Action path layers
        % actPath = [featureInputLayer(prod(actInfo.Dimension))
        %            fullyConnectedLayer(100)
        %            reluLayer
        %            fullyConnectedLayer(50)
        %            reluLayer
        %            fullyConnectedLayer(50,Name="actout")];
        % 
        % % Common path to output layers
        % % Concatenate two layers along dimension one
        % comPath = [concatenationLayer(1,2,Name="cct")
        %            fullyConnectedLayer(100)
        %            reluLayer    
        %            fullyConnectedLayer(1, Name="output")];
        % 
        % % Add layers to network object
        % net = addLayers(layerGraph(obsPath),actPath); 
        % net = addLayers(net,comPath);
        % 
        % % Connect layers
        % net = connectLayers(net,"obsout","cct/in1");
        % net = connectLayers(net,"actout","cct/in2");
        % 
        % % Plot network
        % plot(net)
        % net = dlnetwork(net);
        % critic = rlQValueFunction(net,obsInfo,actInfo);
        % 
        % if standard_agent_options
        %     agent = rlDQNAgent(critic);
        % else
        %     agent = rlDQNAgent(critic, options);
        % end



                % CRITIC
        % Observation path layers
        obsPath = [featureInputLayer(prod(obsInfo.Dimension))
                   fullyConnectedLayer(128)
                   reluLayer
                   fullyConnectedLayer(64)
                   reluLayer
                   fullyConnectedLayer(64,Name="obsout")];

        % Action path layers
        actPath = [featureInputLayer(prod(actInfo.Dimension))
                   fullyConnectedLayer(128)
                   reluLayer
                   fullyConnectedLayer(64)
                   reluLayer
                   fullyConnectedLayer(64,Name="actout")];

        % Common path to output layers
        % Concatenate two layers along dimension one
        comPath = [concatenationLayer(1,2,Name="cct")
                   fullyConnectedLayer(128)
                   reluLayer    
                   fullyConnectedLayer(1, Name="output")];

        % Add layers to network object
        net = addLayers(layerGraph(obsPath),actPath); 
        net = addLayers(net,comPath);

        % Connect layers
        net = connectLayers(net,"obsout","cct/in1");
        net = connectLayers(net,"actout","cct/in2");

        % Plot network
        plot(net)
        net = dlnetwork(net);
        critic = rlQValueFunction(net,obsInfo,actInfo);

        if standard_agent_options
            agent = rlDQNAgent(critic);
        else
            agent = rlDQNAgent(critic, options);
        end

        %                 % CRITIC
        % % Observation path layers
        % obsPath = [featureInputLayer(prod(obsInfo.Dimension))
        %            fullyConnectedLayer(256)
        %            reluLayer
        %            fullyConnectedLayer(128)
        %            reluLayer
        %            fullyConnectedLayer(128,Name="obsout")];
        % 
        % % Action path layers
        % actPath = [featureInputLayer(prod(actInfo.Dimension))
        %            fullyConnectedLayer(256)
        %            reluLayer
        %            fullyConnectedLayer(128)
        %            reluLayer
        %            fullyConnectedLayer(64,Name="actout")];
        % 
        % % Common path to output layers
        % % Concatenate two layers along dimension one
        % comPath = [concatenationLayer(1,2,Name="cct")
        %            fullyConnectedLayer(256)
        %            reluLayer    
        %            fullyConnectedLayer(1, Name="output")];
        % 
        % % Add layers to network object
        % net = addLayers(layerGraph(obsPath),actPath); 
        % net = addLayers(net,comPath);
        % 
        % % Connect layers
        % net = connectLayers(net,"obsout","cct/in1");
        % net = connectLayers(net,"actout","cct/in2");
        % 
        % % Plot network
        % plot(net)
        % net = dlnetwork(net);
        % critic = rlQValueFunction(net,obsInfo,actInfo);
        % 
        % if standard_agent_options
        %     agent = rlDQNAgent(critic);
        % else
        %     agent = rlDQNAgent(critic, options);
        % end

        % 
        % % CRITIC
        % % Observation path layers
        % obsPath = [featureInputLayer(prod(obsInfo.Dimension))
        %            fullyConnectedLayer(5)
        %            reluLayer
        %            fullyConnectedLayer(5,Name="obsout")];
        % 
        % % Action path layers
        % actPath = [featureInputLayer(prod(actInfo.Dimension))
        %             fullyConnectedLayer(5)
        %             reluLayer
        %            fullyConnectedLayer(5,Name="actout")];
        % 
        % % Common path to output layers
        % % Concatenate two layers along dimension one
        % comPath = [concatenationLayer(1,2,Name="cct")
        %             fullyConnectedLayer(5)
        %            reluLayer    
        %            fullyConnectedLayer(1, Name="output")];
        % 
        % % Add layers to network object
        % net = addLayers(layerGraph(obsPath),actPath); 
        % net = addLayers(net,comPath);
        % 
        % % Connect layers
        % net = connectLayers(net,"obsout","cct/in1");
        % net = connectLayers(net,"actout","cct/in2");
        % 
        % % Plot network
        % % plot(net)
        % net = dlnetwork(net);
        % critic = rlQValueFunction(net,obsInfo,actInfo);
        % 
        % 
        % if standard_agent_options
        %     agent = rlDQNAgent(critic);
        % else
        %     agent = rlDQNAgent(critic, options);
        % end
    end
end

