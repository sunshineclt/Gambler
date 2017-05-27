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
            
            % ����������˵��һ�£���Ϊ�ڵ�һ���Դ���4��״̬���ʾ���
            % ��˱��������жϸ���ô������ probability ������Ҫ������һ�ξ���
            % ǰ�͸��������ǶԵ�ǰ����״̬�ĸ��ʾ������ڵ�һ�ξ�������е�
            % ���ϣ��ҽ� probability ����Ϊ��������Ϊ��һ��4��״̬���ֵĸ���
            
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
