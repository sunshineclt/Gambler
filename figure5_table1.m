clear;

problem_count = 100;
trial_count = 100;

agent_count = 14;
reward_record = zeros(problem_count, agent_count);
optimal_record = zeros(problem_count, agent_count);
gain_probability = zeros(problem_count, trial_count);
gain_probability(:, 1) = 0.5;

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
        if i ~= trial_count
            gain_probability(problem, i + 1) = sum(transition(env.status, 1:state / 2));
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
optimal_per = mean(optimal_record);
gain_probability_std = std(gain_probability, 0, 2);

variablity = zeros(1, 5);
proportion = zeros(5, agent_count);
for i = 1:5
    assert(isempty(find(gain_probability_std == 0.5, 1))); % make sure there's no std = 0.5
    
    record = find(gain_probability_std >= 0.1 * (i - 1) & gain_probability_std < 0.1 * i);
    variablity(i) = length(record);
    proportion(i, :) = mean(optimal_record(record, :), 1);
end

fprintf('the optimal_per is %f\n', optimal_per);
fprintf('the mean payoff is %f\n', mpayoff);

hold on;
line_settings = {'-', '-', '-', '-.', '--', '--', '--'};
pictures = [2 5 6 7 9 10 13];
for i = 1:7
    plot(1:5, proportion(:, pictures(i)), line_settings{i});
end
legend('FP', '\alpha = 0.25', '\alpha = 0.5', '\alpha = 0.75','CAB-1','CAB-2','CAB-5');

