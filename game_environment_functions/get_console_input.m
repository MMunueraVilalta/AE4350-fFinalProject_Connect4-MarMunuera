function column = get_console_input()
%% By Mar Munuera - last updated 30/08/2023
    % Function to get a column value from the console (user input)

    % Prompt the user to enter a column value
    prompt = 'Enter a column value (1 to 7): ';
    column = input(prompt);

    % Validate the input to ensure it is within the valid range (1 to 7)
    while ~isnumeric(column) || ~isscalar(column) || column < 1 || column > 7
        disp('Invalid input! Please enter a valid column value (1 to 7).');
        column = input(prompt);
    end
end

