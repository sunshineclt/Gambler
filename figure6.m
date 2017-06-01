clc; clear; close all; fclose all;

addpath(genpath('../Gambler/agent'));
addpath(genpath('../Gambler/env'));

ProbNum = 1000;
TrialNum = 50000; % Trial Number should take 50000 and 100 seperately
AgentNum = 7; % Agent Number in this gambler environment
EnvNum = 10; % Depends on different w
Rewards = zeros(ProbNum, AgentNum, EnvNum); % Record the payment of each agents at 10000 problems
pGainAll = zeros(ProbNum, TrialNum, EnvNum); % Record the pGain of 10000 problems at each trails
pGainRate = zeros(ProbNum, EnvNum); % Record the pGain changing rate of 10000 problems
relativeRewards = zeros(EnvNum, AgentNum); % Record the relative performance of each agents at 10000 problems

for envs = 1:EnvNum
    w = 0.05:0.1:0.95;
    
    for prob = 1:ProbNum
        % set up env
        Vgain = randi([1, 20]);
        Vloss = randi([-20, -1]);
        psame = rand;
        alpha = rand * 2;
        beta = rand * 2;
        env = GraduallyChangingEnv(Vgain, Vloss, psame, alpha, beta, w(envs));

        % set up agent
        FP = DisAvrAgent(1);
        DisAvr3 = DisAvrAgent(0.25);
        DisAvr4 = DisAvrAgent(0.5);
        DisAvr5 = DisAvrAgent(0.75);
        CABk1 = CABKAgent(1);
        CABk2 = CABKAgent(2);
        CABk5 = CABKAgent(5);
        agents = {FP, DisAvr3, DisAvr4, DisAvr5, CABk1, CABk2, CABk5};
        assert(AgentNum == size(agents, 2));
        rewards = zeros(1, AgentNum);
        pGain = zeros(1, TrialNum);

        for trial = 1:TrialNum
            for j = 1:AgentNum
                agent = agents{j};
                action = agent.chooseAction();
                [result, whole_result] = env.getResult(action);
                agent.updateAgent(whole_result);
                rewards(j) = rewards(j) + result;
            end
            pGain(trial) = env.pgain;
            env.transit();
        end
        
        rewards  = rewards / TrialNum;
        Rewards(prob, :, envs) = rewards;
        pGainAll(prob, :, envs) = pGain;
        pGainRate(prob, envs) = mean(abs(diff(pGain)));
%         disp(envs);

    end
    disp(envs);
    rewardsTemp = mean(Rewards(:, :, envs), 1);
    relativeRewards(envs, :) = rewardsTemp / max(rewardsTemp);
end

save('fig_6_T50000_P1000','Rewards','relativeRewards','pGainAll','pGainRate');