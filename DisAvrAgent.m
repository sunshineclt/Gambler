classdef DisAvrAgent < handle
        % Discounted average agent takes decreasing weight for earlier 
        % outcomes.
    
    properties
        alpha % a free parameter
        j
        t
        result
    end
    
    methods
        function obj = DisAvrAgent(alpha,j,t,result)
        % Constructor（初始化）
            obj.alpha = alpha;
            obj.j = j;
            obj.t = t;
            obj.result = result;
        end
        
        function action = chooseAction(obj)
            Qjt = WeiAvrPayoff(obj.j,obj.t,obj.alpha,obj.result);
            if Qjt>0           % 可以认为0是分界吗？
                action = 1;
            else 
                action = 0;
            end
        end
        
        function [j,t,result] = updateAgent(obj, action)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % 拿到上一次action的results（两个option的results都有），更新这个agent，例如更新每种K长度的序列的平均收益
            if action == 1
                result = risky;
                obj.result = result;
            else 
                result = 0;
                obj.result = result;
            end
            j = obj.j+1; obj.j = j;
            t = obj.t+1; obj.t = t;
        end
    end
    
end

