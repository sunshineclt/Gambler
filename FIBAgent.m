classdef FIBAgent < handle
    % EXAMPLEAGENT is an agnet just to show what interfaces should an agent
    % have. It will randomly choose an action each time. 
    
    properties
        % Some Properties of an agent
        % For example, the GGLLG sequence or the data for every possible
        % sequence of K length (每种K长度的序列的平均收益之类的)
        posterior;
        observation;
        value;
        transition;
        threshold;
    end
    
    methods
        function obj = FullyInformedBayesianAgent(gain, loss, transition)
            % Initialization
            obj.observation = double(Status(randi(2)));
            obj.value=[gain, gain, loss, loss]';% 只是针对0.9 0.1的那个矩阵，如果是Figure 4的那种需要修改
            obj.transition = transition;
            obj.threshold=0;
            obj.posterior=[0.5 0.5];
        end
        
        function action = chooseAction(obj)
        % this function should choose an action between 1(risky) and 2(safe)
        % 给出一个action
%         全选risk，全选save，只看上次的
%             action = (rand > 0.5) + 1;
            if min(obj.transition(obj.observation*2,:) * obj.value, obj.transition(obj.observation*2-1,:) * obj.value) > obj.threshold
                action=1;
            else
                if min(obj.transition(obj.observation*2,:) * obj.value, obj.transition(obj.observation*2-1,:) * obj.value) < obj.threshold
                action=2;
                else
                    action=randi(2);
                end
            end
        end
        
        function [] = updateAgent(obj, results, transition)
        % this function should take results (contains every action's result)
        % of last action and update agent. 
        % 拿到上一次action的results（两个option的results都有），更新这个agent，例如更新每种K长度的序列的平均收益
        temp = (results(1) < 0) + 1;% 1 is gain, while 2 is loss
%         if temp == 1
%             if obj.posterior(1)>obj.posterior(2)
%                 obj.observation=1;
%             else
%                 obj.observation=2;
%             end
%             pGain_1
%         else
%             if obj.posterior(3)>obj.posterior(4)
%                 obj.observation=3;
%             else
%                 obj.observation=4;
%             end
%         end
        if obj.observation==1
            if temp==1
                pGain_1=obj.posterior*[obj.transition(1,1)/(obj.transition(1,1)+obj.transition(1,2));obj.transition(2,1)/(obj.transition(2,1)+obj.transition(2,2))];
                obj.posterior=[pGain_1 1-pGain_1];
            else
                pLoss_1=obj.posterior*[obj.transition(1,3)/(obj.transition(1,3)+obj.transition(1,4));obj.transition(2,3)/(obj.transition(2,3)+obj.transition(2,4))];
                obj.posterior=[pLoss_1 1-pLoss_1];
            end
        else
            if temp==1
                pGain_1=obj.posterior*[obj.transition(3,1)/(obj.transition(3,1)+obj.transition(3,2));obj.transition(4,1)/(obj.transition(4,1)+obj.transition(4,2))];
                obj.posterior=[pGain_1 1-pGain_1];
            else
                pLoss_1=obj.posterior*[obj.transition(3,3)/(obj.transition(3,3)+obj.transition(3,4));obj.transition(4,3)/(obj.transition(4,3)+obj.transition(4,4))];
                obj.posterior=[pLoss_1 1-pLoss_1];
            end
        end
%         pGain_1=obj.posterior(3:4)*[obj.transition(3,1)/(obj.transition(3,1)+obj.transition(3,3));obj.transition(4,1)/(obj.transition(4,1)+obj.transition(4,3))];
%         pLoss_1=obj.posterior(1:2)*[obj.transition(1,2)/(obj.transition(1,2)+obj.transition(1,4));obj.transition(2,2)/(obj.transition(2,2)+obj.transition(2,4))];
%         obj.posterior(pGain_1,1-pGain_1,pLoss_1,1-pLoss_1);
      end
    
end
