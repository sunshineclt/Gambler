classdef FIBAgent < handle
    properties
        value;
        transition;
        safe;
        probability;
    end
    
    methods
        function obj = FIBAgent(gain, loss, transition)
            obj.value=[gain, gain, loss, loss]';
            obj.transition = transition;
            obj.safe=0;
            obj.probability=[0.25, 0.25, 0.25, 0.25];
            % in the first trial the 4 probabilities are equal
            
            % 这里我着重说明一下，因为在第一个试次中4个状态概率均等
            % 因此被试用来判断该怎么决定的 probability 矩阵需要在做第一次决定
            % 前就给出，但是对当前所处状态的概率矩阵是在第一次决定后才有的
            % 综上，我将 probability 定义为：被试认为下一次4个状态出现的概率
            
        end
        
        function action = chooseAction(obj)
            expectation = obj.probability * obj.value;            
            if expectation == obj.safe
                action = randi(2);
            else
                if expectation < obj.safe
                    action = 2;
                end
                if expectation > obj.safe
                    action = 1;
                end
                if expectation == obj.safe
                    action = (rand > 0.5) + 1;
                end
            end
        end
        
        function [] = updateAgent(obj, results)
            % since at this moment the subject has known the result of this
            % trial, so he will upgrate his knowledge about the present
            % status of this trial
            if results(1) > 0
                p_Gain1 = obj.probability(1) / (obj.probability(1) + obj.probability(2));
                obj.probability = [p_Gain1, 1 - p_Gain1, 0, 0];
            else
                p_Loss1 = obj.probability(3) / (obj.probability(3) + obj.probability(4));
                obj.probability = [0, 0, p_Loss1, 1 - p_Loss1];
            end
            
            obj.probability = obj.probability * obj.transition;
        end
    end
end
