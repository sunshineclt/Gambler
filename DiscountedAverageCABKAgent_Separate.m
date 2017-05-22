classdef DiscountedAverageCABKAgent < handle
        
    properties
        k % length of the sequence
        experience % the past experience of every k sequence
        sequence % the last k sequence
        trial
        Separate_Trial
        Qsafe
        Qrisky
        alpha
    end
    
    methods
        function obj = CABKAgent(alpha, k)
            obj.k = k;
            obj.experience = zeros(2^k, 1); 
            obj.sequence = 0;
            obj.trial = 0;
            obj.Separate_Trial = zeros(2^k, 1);
            obj.alpha = alpha;
        end
        
        function action = chooseAction(obj)
            if obj.experience(obj.sequence + 1) == 0
                action = (rand > 0.5) + 1;
            else
                action = (obj.experience(obj.sequence + 1) < 0) + 1;
            end
        end
        
        function [] = updateAgent(obj, results)
            obj.trial = obj.trial + 1;
            if obj.trial > obj.k
                obj.Separate_Trial(obj.sequence + 1) = obj.Separate_Trial(obj.sequence + 1) + 1;
                obj.experience(obj.sequence + 1) = ...
                (1 - 1 / (obj.Separate_Trial(obj.sequence + 1)^obj.alpha)) * obj.experience(obj.sequence + 1) ...
                + 1 / (obj.Separate_Trial(obj.sequence + 1)^obj.alpha) * results(1);
            end
            obj.sequence = mod(obj.sequence, 2 ^ (obj.k - 1)) * 2 + (results(1) > results(2));
        end
    end
    
end

