clear;

problem_count = 10000;
trial_count = 50000;

agent_count = 14;
gain_probability = zeros(problem_count, agent_count);
risky_action_probability  = zeros(problem_count, agent_count);
correlation = zeros(1, agent_count);

for problem = 1:problem_count
    % set up env    
    gain = randi([1, 20]);
    loss = randi([-20, -1]);
    state = 4;
    transition = zeros(state);
    for row = 1:state
        column = randi(state);
        unique =  ((state - 1) * rand + 1) / state;
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
    gain_sum = zeros(1, agent_count);
    risky_action_sum = zeros(1, agent_count);
    
    for i = 1:trial_count
        for j = 1:agent_count
            agent = agents{j};
            action = agent.chooseAction();
            risky_action_sum(j) = risky_action_sum(j) + (action == 1);
            [result, whole_result] = env.getResult(action);
            gain_sum(j) = gain_sum(j) + (whole_result(1) > 0);
            agent.updateAgent(whole_result);
        end
        env.transit();
    end
    gain_probability(problem, :)  = gain_sum / trial_count;
    risky_action_probability(problem, :) = risky_action_sum / trial_count;
    disp(problem);
end

for i = 1:agent_count
    correlation(i) = corr(gain_probability(:, i), risky_action_probability(:, i), 'type', 'pearson');
end
save('table3.mat', 'correlation');