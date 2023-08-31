# AE4350-fFinalProject_Connect4-MarMunuera
Project for the course AE4350 - Bio-inspired Intelligence and learning for Aerospace Applications. This project aims to use RL in the board game Connect 4.

## Set up
This project has been coded in MATLAB and requires the following: Reinforcement Learning Toolbox, Deep Learning Toolbox and Parallel Computing Toolbox.

The code is structured into folders.
- Environment -> Contains all the environment matlab files to simulate the different environments presented in the report
- Visualizer -> Contains the board game visualizer tool
- game_environment_functions -> Contains all the functions that carry out sub-processes.
- agent_functions -> Contains all the functions that create agents.
- performance_tests -> Contains the tests done to evaluate the functioning and training of the agents
- DQN -> Contains trained agent files and results file
- Images -> Contains some of the figures extracted and used in the report.
- test_minimax -> Contains the function to test the minimax implementation


It is important that in order to use the code, all the folders must be added to the main path manually.

The main file is train_RL_agent, that allows to train a DQN, SARSA, PG, AC, PPO and TRPO agent. However, only the DQN agent has been properly analysed in this project.

## Additional consideration for visualization
Currently the training algorithm is implemented using parallel computing. When parallel computing is done, the visualizer dissapears and the "win", "loose" or "tie" messages have to be commented for it to work properly. This is the current configuration.
If parallel computing is not wanted then comment the following lines: 

""
trainingOptions.UseParallel=true;
trainingOptions.ParallelizationOptions.Mode="async";
""