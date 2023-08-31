function [agent] = AC_agent(obsInfo, actInfo, use_default_neural_network, standard_agent_options, options)
% AC_AGENT 

    % Define the agent
    
    if use_default_neural_network

        if standard_agent_options
            agent = rlACAgent(obsInfo,actInfo);
    
        else
            agent = rlACAgent(obsInfo,actInfo, options);
        end
    
    else

        numObs  = obsInfo.Dimension(1);
        numAct  = numel(actInfo);

        % CRITIC
        criticNetwork = [
            featureInputLayer(numObs, 'Normalization', 'none', 'Name', 'observation')
            fullyConnectedLayer(128, 'Name', 'CriticFC1')
            reluLayer('Name', 'CriticRelu1')
            fullyConnectedLayer(64, 'Name', 'CriticFC2')
            reluLayer('Name', 'CriticRelu2')
            fullyConnectedLayer(1, 'Name', 'Output')];
        
        criticNet = dlnetwork(criticNetwork);
        critic = rlValueFunction(criticNet,obsInfo);
        
        % ACTOR
        actorNet = [
        featureInputLayer(numObs, 'Normalization', 'none', 'Name', 'observation')
            fullyConnectedLayer(128, 'Name', 'ActorFC1')
            reluLayer('Name', 'ActorRelu1')
            fullyConnectedLayer(64, 'Name', 'ActorFC2')
            reluLayer('Name', 'ActorRelu2')
            fullyConnectedLayer(7, 'Name', 'Action')]; % Number of output nodes matches the number of discrete actions
        
        actor = rlDiscreteCategoricalActor(actorNet,obsInfo,actInfo);
        
        % AGENT
        if standard_agent_options
            agent = rlACAgent(actor,critic);
        else
            agent = rlACAgent(actor,critic, options);
        end

    end

end

