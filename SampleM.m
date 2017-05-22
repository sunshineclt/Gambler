classdef SampleM < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        m % m samples from past experience
        i % trial number        
    end
    
    methods
        function obj = SampleM()
        obj.m = 9;
        t = 1;
        sample_array = round(rand(1,10)*t);
        end
        
        
        function action = chooseAction(obj,result,t,sample_array)
        if obj.m >= t
            if mean(result(1)) > 0
                action = 1;
            end
            if mean(result(1)) == 0
                action = (rand > 0.5) + 1;
            end
            if mean(result(1)) < 0
                action = 2;
            end
        else
            if mean(result(sample_array)) > 0
                action = 1;
            end
            if mean(result(sample_array)) == 0
                action = (rand > 0.5) + 1;
            end
            if mean(result(sample_array)) < 0
                action = 2;
            end
        end
        t = t+1;    
        end
        
        function [] = updateAgent(whole_result)
            result = whole_result;   
        end
    end
    
end