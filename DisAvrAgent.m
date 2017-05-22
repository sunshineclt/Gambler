classdef DisAvrAgent < handle
        % Discounted average agent takes decreasing weight for earlier 
        % outcomes.
    
    properties
        alpha % a free parameter
        t
        Qsafe
        Qrisky
    end
    
    methods
        function obj = DisAvrAgent(alpha)
        % Constructor（初始化）
            obj.alpha = alpha;
            obj.t = 0;
            obj.Qsafe = 0;
            obj.Qrisky = 0;
        end
        
        function action = chooseAction(obj)
            if obj.Qrisky > obj.Qsafe
                action = 1;
            end
            if obj.Qrisky < obj.Qsafe
                action = 2;
            end
            if obj.Qrisky == obj.Qsafe
                action = (rand > 0.5) + 1;
            end
        end
        
        function [] = updateAgent(obj, V)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % 拿到上一次action的results（两个option的results都有），更新这个agent，例如更新每种K长度的序列的平均收益
            obj.t = obj.t + 1;
            obj.Qrisky = WeiAvrPayoff(obj.Qrisky, obj.t, obj.alpha, V(1));
            obj.Qsafe = WeiAvrPayoff(obj.Qsafe, obj.t, obj.alpha, V(2));
        end
    end
    
end

