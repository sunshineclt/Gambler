env = TwoOptionsEnv(10, -1, [0.1, 0.9; 0.9, 0.1]);
agent = CABKAgent(2);

reward = 0;
for i = 1:10000
    action = agent.chooseAction();
    [result, whole_result] = env.step(action);
    reward = reward + result;
    agent.updateAgent(whole_result);
end

disp(reward);