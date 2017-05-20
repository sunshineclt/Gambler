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
        % Constructor����ʼ����
            obj.alpha = alpha;
            obj.j = j;
            obj.t = t;
            obj.result = result;
        end
        
        function action = chooseAction(obj)
            Qjt = WeiAvrPayoff(obj.j,obj.t,obj.alpha,obj.result);
            if Qjt>0           % ������Ϊ0�Ƿֽ���
                action = 1;
            else 
                action = 0;
            end
        end
        
        function [j,t,result] = updateAgent(obj, action)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % �õ���һ��action��results������option��results���У����������agent���������ÿ��K���ȵ����е�ƽ������
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

