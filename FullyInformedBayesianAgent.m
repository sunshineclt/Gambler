classdef FullyInformedBayesianAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (每种K长度的序列的平均收益之类的)
        
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
        % 给出一个action
%         全选risk，全选save，只看上次的课
            action = (rand > 0.5) + 1;
        end
        
        function [pastChoice, pastResult] = updateAgent(obj, results)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % 拿到上一次action的results（两个option的results都有），更新这个agent，例如更新每种K长度的序列的平均收益
        
        
        end
    end
    
end

