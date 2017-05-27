classdef FIBAgent < handle
    properties
        status_num;
        value;
        transition;
        safe;
        probability;
    end
    
    methods
        function obj = FIBAgent(gain, loss, transition)
            obj.status_num = size(transition, 1);
            obj.value=[repmat(gain, [obj.status_num / 2, 1]), repmat(loss, [obj.status_num / 2, 1])];
            obj.transition = transition;
            obj.safe=0;
            obj.probability=repmat(1 / n, [n, 1]);
            % in the first trial the n probabilities are equal
            
            % ����������˵��һ�£���Ϊ�ڵ�һ���Դ���n��״̬���ʾ���
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
                else
                    action = 1;
                end
            end
        end
        
        function [] = updateAgent(obj, results)
            % since at this moment the subject has known the result of this
            % trial, so he will upgrate his knowledge about the present
            % status of this trial
            if results(1) > 0
                obj.probability(obj.status_num / 2 + 1:end) = 0;
                gain_sum = sum(obj.probability);
                obj.probability = obj.probability  / gain_sum;
            else
                obj. probability(1:obj.status_num / 2) = 0;
                loss_sum = sum(obj.probability);
                obj.probability = obj.probability / loss_sum;
            end
            
            obj.probability = obj.probability * obj.transition;
        end
    end
end
