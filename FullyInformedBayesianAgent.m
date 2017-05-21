classdef FullyInformedBayesianAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (ÿ��K���ȵ����е�ƽ������֮���)
        choice;
        value;
        transition;
        threshold;
    end
    
    methods
        function obj = FullyInformedBayesianAgent(env)
%       Initialization
        obj.choice(1)=double(Status(randi(2)));
        obj.value=[env.loss,env.gain];% ֻ�����0.9 0.1���Ǹ����������Figure 4��������Ҫ�޸�
        obj.transition = env.transition;
        obj.threshold=0;
            
        end
        
        function action = chooseAction(obj)
        % this function should choose an action between 1(risky) and 2(safe)
        % ����һ��action
%         ȫѡrisk��ȫѡsave��ֻ���ϴεĿ�
%             action = (rand > 0.5) + 1;
            if obj.transition(obj.choice(end),:)*obj.value>0
                action=1;
            else
                action=2;
            end
        end
        
        function [] = updateAgent(obj, results, action)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % �õ���һ��action��results������option��results���У����������agent���������ÿ��K���ȵ����е�ƽ������
        obj.choice=[obj.choice,action];        
        
        end
    end
    
end

