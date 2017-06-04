clear;

problem_count = 1000;
trial_count = 100;

agent_count = 14;
reward_record = zeros(problem_count, agent_count);
optimal_record = zeros(problem_count, agent_count);

for problem = 1:problem_count
    % set up env    
    gain = randi([1, 20]);
    loss = randi([-20, -1]);
    state = 4;
    transition = zeros(state);
    for row = 1:state
        column = randi(state);
        unique = ((state - 1) * rand + 1) / state;
        transition(row, :) = (1 - unique) / (state - 1);
        transition(row, column) = unique;
    end
    env = TwoOptionsEnv(state, gain, loss, transition);

    % set up agent
    FIBA = FIBAgent(gain, loss, transition);
    FP = DisAvrAgent(1);
    DiscountedAverageCABK1 = DiscountedAverageCABKAgent(0, 1);
    DiscountedAverageCABK2 = DiscountedAverageCABKAgent(0, 3);
    DiscountedAverageCABK3 = DiscountedAverageCABKAgent(0, 5);
    DiscountedAverageCABK4 = DiscountedAverageCABKAgent(0.1, 1);
    DiscountedAverageCABK5 = DiscountedAverageCABKAgent(0.1, 3);
    DiscountedAverageCABK6 = DiscountedAverageCABKAgent(0.1, 5);
    DiscountedAverageCABK7 = DiscountedAverageCABKAgent(0.5, 1);
    DiscountedAverageCABK8 = DiscountedAverageCABKAgent(0.5, 3);
    DiscountedAverageCABK9 = DiscountedAverageCABKAgent(0.5, 5);
    DiscountedAverageCABK10 = DiscountedAverageCABKAgent(0.9, 1);
    DiscountedAverageCABK11 = DiscountedAverageCABKAgent(0.9, 3);
    DiscountedAverageCABK12 = DiscountedAverageCABKAgent(0.9, 5);
    agents = {FIBA, FP, DiscountedAverageCABK1, DiscountedAverageCABK2, DiscountedAverageCABK3, ...
        DiscountedAverageCABK4, DiscountedAverageCABK5, DiscountedAverageCABK6, ...
        DiscountedAverageCABK7, DiscountedAverageCABK8, DiscountedAverageCABK9, ...
        DiscountedAverageCABK10, DiscountedAverageCABK11, DiscountedAverageCABK12};
    assert(agent_count == size(agents, 2));
    rewards = zeros(1, agent_count);
    optimal = zeros(1, agent_count);
    
    for i = 1:trial_count
        action_FIBA = agents{1}.chooseAction();
        [result, whole_result] = env.getResult(action_FIBA);
        agents{1}.updateAgent(whole_result);
        rewards(1) = rewards(1) + result;
        optimal(1) = optimal(1) + 1;
        for j = 2:agent_count
            agent = agents{j};
            action = agent.chooseAction();
            [result, whole_result] = env.getResult(action);
            agent.updateAgent(whole_result);
            rewards(j) = rewards(j) + result;
            optimal(j) = optimal(j) + (action == action_FIBA);
        end
        env.transit();
    end
    rewards  = rewards / trial_count;
    % disp(rewards);
    reward_record(problem, :) = rewards;
    optimal_record(problem, :) = optimal / trial_count;
    disp(problem);
end

mpayoff = mean(reward_record);
optrial_per = mean(optimal_record);
save('table1.mat', 'reward_record', 'optimal_record','optrial_per', 'mpayoff');