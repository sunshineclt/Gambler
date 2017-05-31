clear;

problem_count = 10000;
trial_count = 100;

agent_count = 14;
reward_record = zeros(problem_count, agent_count);
optimal_record = zeros(problem_count, agent_count);

for problem = 1:problem_count
    % set up env    
    gain = randi([1, 20]);
    loss = randi([-20, -1]);
    state = 4;
    transition = zeros(state, state);
    for row = 1:state
        column = randi([1, state]);
        unique = rand()*(state-1)/state + 1/state;
        transition(row, :) = (1 - unique) / (state - 1);
        transition(row, column) = unique;
    end
    env = TwoOptionsEnv(state, gain, loss, transition);

    % set up agent
    FIBA = FIBAgent(gain, loss, transition);
    FP = DisAvrAgent(1);
    DisAvr1 = DisAvrAgent(0);
    DisAvr2 = DisAvrAgent(0.1);
    DisAvr3 = DisAvrAgent(0.25);
    DisAvr4 = DisAvrAgent(0.5);
    DisAvr5 = DisAvrAgent(0.75);
    DisAvr6 = DisAvrAgent(0.9);
    CABk1 = CABKAgent(1);
    CABk2 = CABKAgent(2);
    CABk3 = CABKAgent(3);
    CABk4 = CABKAgent(4);
    CABk5 = CABKAgent(5);
    CABk6 = CABKAgent(6);
    agents = {FIBA, FP, DisAvr1, DisAvr2, DisAvr3, DisAvr4, DisAvr5, DisAvr6, CABk1, CABk2, CABk3, CABk4, CABk5, CABk6};
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