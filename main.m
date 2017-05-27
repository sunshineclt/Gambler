env = TwoOptionsEnv(4, 10, -1, [0.7 0.1 0.1 0.1;
                             0.1 0.7 0.1 0.1;
                             0.1 0.1 0.7 0.1;
                             0.1 0.1 0.1 0.7]);
agent = FIBAgent(10, -1, [0.7 0.1 0.1 0.1;
                             0.1 0.7 0.1 0.1;
                             0.1 0.1 0.7 0.1;
                             0.1 0.1 0.1 0.7]);

reward = 0;
for i = 1:100
    action = agent.chooseAction();
    [result, whole_result] = env.step(action);
    reward = reward + result;
    agent.updateAgent(whole_result);
end

disp(reward);