classdef FullyInformedBayesianAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (每种K长度的序列的平均收益之类的)
        observation;
        value;
        transition;
        threshold;
    end
    
    methods
        function obj = FullyInformedBayesianAgent(gain, loss, transition)
            % Initialization
            obj.observation = double(Status(randi(2)));
            obj.value=[gain, loss]';% 只是针对0.9 0.1的那个矩阵，如果是Figure 4的那种需要修改
            obj.transition = transition;
            obj.threshold=0;
        end
        
        function action = chooseAction(obj)
        % this function should choose an action between 1(risky) and 2(safe)
        % 给出一个action
%         全选risk，全选save，只看上次的
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
        % 拿到上一次action的results（两个option的results都有），更新这个agent，例如更新每种K长度的序列的平均收益
            obj.observation = (results(1) < 0) + 1;
        end
    end
    
end
