classdef TwoOptionsEnv < handle
    % TWOOPTIONSENV is a game env that have 2 options for player to choose. 
    % Option 1 is a risky option which means to have a state to indicate
    % whether it's in a loss state or a gain state. 
    % Option 2 is a safe option which means to have a 0 payoff all the
    % time. 
    % Option 1 has an internal state which indicates whether it will output 
    % gain or loss. This internal state has Markov property and thus after 
    % every action it will transite to a new state according to transition
    % matrix. 
    % In this env, the number of state is appointed in the constructor. 
    
    properties
        status % current internal state of option risky
        value % value amount of every state of risky choice
        transition % transition matrix
        number_of_state % number_of_state
    end
    
    methods
        function obj = TwoOptionsEnv(number_of_state, gain, loss, transition)
        % Constructor
            obj.number_of_state = number_of_state;
            obj.status = randi(number_of_state);
            obj.value = [repmat([gain], [1, number_of_state / 2]), repmat([loss], [1, number_of_state / 2])];
            obj.transition = transition;
        end
        
        function [result, whole_result] = step(obj, action)
        % take an action, give a result and then transite interal state
        % Parameter: action 1 = risky, action 2 = safe
        % Return: 
        %   result: the chosen action's result
        %   whole_result: two actions's result     
            risky = obj.value(obj.status);
            if action == 1
                result = risky;
                whole_result = [risky, 0];
            else
                result = 0;
                whole_result = [risky, 0];
            end
            ran = rand;
            cp = cumsum(obj.transition(obj.status, :));
            obj.status = sum(cp < ran)+1;
        end
    end
    
end
