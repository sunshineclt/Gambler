classdef SampleMAgent < handle
    % SAMPLEMAgent is an agnet to judge the option based on m samples of 
    % its former experience. 
    
    properties
        m % m samples from past experience
        i % trial number      
        t
        observations
    end
    
    methods
        function obj = SampleMAgent(m)
            obj.m = m;
            obj.t = 0;
        end
        
        function action = chooseAction(obj)
            if obj.t < obj.m
                action = (rand > 0.5) + 1;
            else
                value = mean(obj.observations(randi(obj.t, [1, obj.m])));
                if value > 0
                    action = 1;
                end
                if value == 0
                    action = (rand > 0.5) + 1;
                end
                if value < 0
                    action = 2;
                end
            end
        end
        
        function [] = updateAgent(obj, whole_result)
            obj.observations = [obj.observations, whole_result(1)];
            obj.t = obj.t + 1;
        end
    end
    
end