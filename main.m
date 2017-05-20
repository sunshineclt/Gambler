env = ChangingTwoOptionsEnv(1, -1, 0.1, 2, 2);
agent = CABKAgent(6);

reward = 0;
for i = 1:100
    action = agent.chooseAction();
    [result, whole_result] = env.step(action);
    reward = reward + result;
    agent.updateAgent(whole_result);
end

disp(reward);