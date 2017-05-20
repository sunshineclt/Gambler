classdef TwoOptionsEnv < handle
    % TWOOPTIONSENV is a game env that have 2 options for player to choose. 
    % Option 1 is a risky option which means to have p_loss probability to
    % get a loss, and to have p_gain probability to get a gain
    % Option 2 is a safe option which means to have a 0 payoff all the time
    % Option 1 has an internal state indicates whether it will be gain or
    % loss. This internal state has Markov property and thus after every
    % action it will transite to a new state according to transition
    % matrix. 
    
    properties
        status % current internal state of option risky
        loss % loss amount of risky choice
        gain % gain amount of risky choice
        transition % transition matrix
    end
    
    methods
        function obj = TwoOptionsEnv(loss, gain, transition)
        % Constructor
            obj.status = Status(randi(2)); % TODO: ³õÊ¼×´Ì¬ÔõÃ´¶¨£¿
            obj.loss = loss;
            obj.gain = gain;
            obj.transition = transition;
        end
        
        function [result, whole_result] = step(obj, action)
        % take an action, give a result and then transite its interal state
        % Parameter: action 1 = risky, action 2 = safe
        % Return: 
        %   result: this action's result
        %   whole_result: two actions's result            
            if obj.status == Status.Loss
                risky = obj.loss;
            else
                risky = obj.gain;
            end
            if action == 1
                result = risky;
                whole_result = [risky, 0];
            else
                result = 0;
                whole_result = [risky, 0];
            end
            if rand <= obj.transition(double(obj.status), 1)
                obj.status = Status.Gain;
            else
                obj.status = Status.Loss;
            end
        end
    end
    
end

