classdef FullyInformedBayesianAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (ÿ��K���ȵ����е�ƽ������֮���)
        
    end
    
    methods
        function obj = FullyInformedBayesianAgent(env)
        obj.loss = env.loss;
        obj.ploss = env.ploss;
        obj.gain = env.gain;
        obj.transition = env.transition;
            
        end
        
        function action = chooseAction(obj)
        % this function should choose an action between 1(risky) and 2(safe)
        % ����һ��action
%         ȫѡrisk��ȫѡsave��ֻ���ϴεĿ�
            action = (rand > 0.5) + 1;
        end
        
        function [pastChoice, pastResult] = updateAgent(obj, results)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % �õ���һ��action��results������option��results���У����������agent���������ÿ��K���ȵ����е�ƽ������
        
        
        end
    end
    
end

