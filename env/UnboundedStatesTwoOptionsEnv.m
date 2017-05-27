classdef UnboundedStatesTwoOptionsEnv < handle
    % UNBOUNDEDSTATESTWOOPTIONSENV is a game env that have 2 options for 
    % player to choose. 
    % Option 1 is a risky option which means to have a probability to gain
    % and a probability to loss
    % Option 2 is a safe option which means to have a 0 payoff all the time
    % This env do not have state or transition matrix. Instead it has the
    % `pgain` to indicate the probability of gain. And after each action,
    % it will modify `pgain` with the probability `1 - psame`, and if
    % modified, the new `pgain` will be drawn from a beta distribution
    % whose parameter is alpha and beta. 
    
    properties
        loss % loss amount of risky choice
        pgain % probability of gain
        gain % gain amount of risky choice
        psame % probability of unchanged pgain
        alpha % alpha parameter for beta distribution
        beta % beta parameter for beta distribution
    end
    
    methods
        function obj = UnboundedStatesTwoOptionsEnv(gain, loss, psame, alpha, beta)
        % Constructor
            obj.loss = loss;
            obj.gain = gain;
            obj.pgain = betarnd(alpha, beta);
            obj.psame = psame;
            obj.alpha = alpha;
            obj.beta = beta;
        end
        
        function [result, whole_result] = getResult(obj, action)
        % Take an action, give a result, but not transit pgain. 
        % For pgain transition, see `transit` 
        % Parameter: action 1 = risky, action 2 = safe
        % Return: 
        %   result: the chosen action's result
        %   whole_result: two actions's result   
            if rand <= obj.pgain
                risky = obj.gain;
            else
                risky = obj.loss;
            end
            if action == 1
                result = risky;
                whole_result = [risky, 0];
            else
                result = 0;
                whole_result = [risky, 0];
            end
        end
        
        function [] = transit(obj)
        % Transit pgain
            if rand > obj.psame
                obj.pgain = betarnd(obj.alpha, obj.beta);
            end
        end
    end
    
end
