classdef TwoOptionsEnv_static < handle
    % TWOOPTIONSENV is a game env that have 2 options for player to choose. 
    % Option 1 is a risky option which means to have a state to indicate
    % whether it's in a loss state or a gain state
    % Option 2 is a safe option which means to have a 0 payoff all the time
    % Option 1 has an internal state indicates whether it will be gain or
    % loss. This internal state has Markov property and thus after every
    % action it will transite to a new state according to transition
    % matrix. 
    
    properties
        status % current internal state of option risky
        value % value amount of every state of risky choice
        transition % transition matrix
    end
    
    methods
        function obj = TwoOptionsEnv(gain, loss, transition)
        % Constructor
            obj.status = Status(randi(2));
            obj.value = [gain, loss];
            obj.transition = transition;
        end
        
        function [result, whole_result] = step(obj, action)
        % take an action, give a result and then transite its interal state
        % Parameter: action 1 = risky, action 2 = safe
        % Return: 
        %   result: this action's result
        %   whole_result: two actions's result     
            risky = obj.value(double(obj.status));
            if action == 1
                result = risky;
                whole_result = [risky, 0];
            else
                result = 0;
                whole_result = [risky, 0];
            end
            ran = rand;
            cp = cumsum(obj.transition(double(obj.status), :));
            obj.status = Status(sum(cp < ran)+1);
        end
    end
    
end