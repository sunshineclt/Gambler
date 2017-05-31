clear;

problem_count = 1000;
trial_count = 50000;

agent_count = 13;
reward_record = zeros(problem_count, agent_count);
optimal_record = zeros(problem_count, agent_count);

for problem = 1:problem_count
    % set up env
    gain = randi([1, 20]);
    loss = randi([-20, -1]);
    psame = rand;
    alpha = rand * 2;
    beta = rand * 2;
    env = UnboundedStatesTwoOptionsEnv(gain, loss, psame, alpha, beta);

    % set up agent
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
    agents = {FP, DisAvr1, DisAvr2, DisAvr3, DisAvr4, DisAvr5, DisAvr6, CABk1, CABk2, CABk3, CABk4, CABk5, CABk6};
    assert(agent_count == size(agents, 2));
    rewards = zeros(1, agent_count);
    
    for i = 1:trial_count
        for j = 1:agent_count
            agent = agents{j};
            action = agent.chooseAction();
            [result, whole_result] = env.getResult(action);
            agent.updateAgent(whole_result);
            rewards(j) = rewards(j) + result;
        end
        env.transit();
    end
    rewards  = rewards / trial_count;
    % disp(rewards);
    reward_record(problem, :) = rewards;
    disp(problem);
end

save('table5.mat', 'reward_record');