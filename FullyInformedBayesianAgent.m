classdef FullyInformedBayesianAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (ÿ��K���ȵ����е�ƽ������֮���)
        observation;
        value;
        transition;
        threshold;
    end
    
    methods
        function obj = FullyInformedBayesianAgent(gain, loss, transition)
            % Initialization
            obj.observation = double(Status(randi(2)));
            obj.value=[gain, loss]';% ֻ�����0.9 0.1���Ǹ����������Figure 4��������Ҫ�޸�
            obj.transition = transition;
            obj.threshold=0;
        end
        
        function action = chooseAction(obj)
        % this function should choose an action between 1(risky) and 2(safe)
        % ����һ��action
%         ȫѡrisk��ȫѡsave��ֻ���ϴε�
%             action = (rand > 0.5) + 1;
            if obj.transition(obj.observation,:) * obj.value > obj.threshold
                action=1;
            else
                action=2;
            end
        end
        
        function [] = updateAgent(obj, results)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % �õ���һ��action��results������option��results���У����������agent���������ÿ��K���ȵ����е�ƽ������
            obj.observation = (results(1) < 0) + 1;
        end
    end
    
end
