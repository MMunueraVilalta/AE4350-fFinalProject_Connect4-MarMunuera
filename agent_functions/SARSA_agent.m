function [agent] = SARSA_agent(obsInfo, actInfo, use_default_neural_network, standard_agent_options, options)
% SARSA_AGENT 

    % Define the agent
    
    if use_default_neural_network

        disp("SARSA method is not coded for a default critic network. A defined critic will be used instead.")

        % CRITIC
        % Observation path layers
        obsPath = [featureInputLayer(prod(obsInfo.Dimension))
                   fullyConnectedLayer(5)
                   reluLayer
                   fullyConnectedLayer(5,Name="obsout")];
        
        % Action path layers
        actPath = [featureInputLayer(prod(actInfo.Dimension))
                   fullyConnectedLayer(5)
                   reluLayer
                   fullyConnectedLayer(5,Name="actout")];
        
        % Common path to output layers
        % Concatenate two layers along dimension one
        comPath = [concatenationLayer(1,2,Name="cct")
                   fullyConnectedLayer(5)
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

        
        % AGENT
        if standard_agent_options
            disp("YESSS")
            agent = rlSARSAAgent(critic);
        else
            agent = rlSARSAAgent(critic, options);
        end
    
    else
        % CRITIC
        % Observation path layers
        obsPath = [featureInputLayer(prod(obsInfo.Dimension))
                   fullyConnectedLayer(5)
                   reluLayer
                   fullyConnectedLayer(5,Name="obsout")];
        
        % Action path layers
        actPath = [featureInputLayer(prod(actInfo.Dimension))
                   fullyConnectedLayer(5)
                   reluLayer
                   fullyConnectedLayer(5,Name="actout")];
        
        % Common path to output layers
        % Concatenate two layers along dimension one
        comPath = [concatenationLayer(1,2,Name="cct")
                   fullyConnectedLayer(5)
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

        
        % AGENT
        if standard_agent_options
            agent = rlSARSAAgent(critic);
        else
            agent = rlSARSAAgent(critic, options);
        end

    end

end

