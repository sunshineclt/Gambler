%% agent setting
FIBA = FIBAgent(Vgain, Vloss, transition);
FP = DisAvrAgent(1); FP_OpTrial = 0;
DisAvr1 = DisAvrAgent(0); DA1_OpTrial = 0;
DisAvr2 = DisAvrAgent(0.25); DA2_OpTrial = 0;
DisAvr3 = DisAvrAgent(0.5); DA3_OpTrial = 0;
DisAvr4 = DisAvrAgent(0.75); DA4_OpTrial = 0;
DisAvr5 = DisAvrAgent(0.9); DA5_OpTrial = 0;
CABk1 = CABKAgent(1); CABk1_OpTrial = 0;
CABk2 = CABKAgent(2); CABk2_OpTrial = 0;
CABk3 = CABKAgent(3); CABk3_OpTrial = 0;
CABk4 = CABKAgent(4); CABk4_OpTrial = 0;
CABk5 = CABKAgent(5); CABk5_OpTrial = 0;
CABk6 = CABKAgent(6); CABk6_OpTrial = 0;
FIBA_reward = 0;
FP_reward = 0; DisAvr1_reward = 0; DisAvr2_reward = 0;
DisAvr3_reward = 0; DisAvr4_reward = 0; DisAvr5_reward = 0;
CABk1_reward = 0; CABk2_reward = 0; CABk3_reward = 0;
CABk4_reward = 0; CABk5_reward = 0; CABk6_reward = 0;

ProbNum = 1;
TrialNum = 100; % Trial Number should take 100 only
for prob = 1:ProbNum
    %% game environment parameters
    transition = [0.9,0.1;0.9,0.1];
    Vgain = 1;
    Vloss = -10;
    env = TwoOptionsEnv(Vgain, Vloss, transition);
    %% trials for each problem and agents take actions
    for trial = 1:TrialNum
        % FIBA
        FIBA_action = FIBA.chooseAction();
        [result, whole_result] = env.step(FIBA_action);
        FIBA_reward = FIBA_reward + result;
        FIBA.updateAgent(whole_result);
        % FP
        FP_action = FP.chooseAction();
        [result, whole_result] = env.step(FP_action);
        FP_reward = FP_reward + result;
        FP.updateAgent(whole_result);
        if FP_action == FIBA_action
            FP_OpTrial = FP_OpTrial+1;
        end
        % DisAvr
        DisAvr1_action = DisAvr1.chooseAction();
        [result, whole_result] = env.step(DisAvr1_action);
        DisAvr1_reward = DisAvr1_reward + result;
        DisAvr1.updateAgent(whole_result);
        if DisAvr1_action == FIBA_action
            DA1_OpTrial = DA1_OpTrial+1;
        end
        DisAvr2_action = DisAvr2.chooseAction();
        [result, whole_result] = env.step(DisAvr2_action);
        DisAvr2_reward = DisAvr2_reward + result;
        DisAvr2.updateAgent(whole_result);
        if DisAvr2_action == FIBA_action
            DA2_OpTrial = DA2_OpTrial+1;
        end
        DisAvr3_action = DisAvr3.chooseAction();
        [result, whole_result] = env.step(DisAvr3_action);
        DisAvr3_reward = DisAvr3_reward + result;
        DisAvr3.updateAgent(whole_result);
        if DisAvr3_action == FIBA_action
            DA3_OpTrial = DA3_OpTrial+1;
        end
        DisAvr4_action = DisAvr4.chooseAction();
        [result, whole_result] = env.step(DisAvr4_action);
        DisAvr4_reward = DisAvr4_reward + result;
        DisAvr4.updateAgent(whole_result);
        if DisAvr4_action == FIBA_action
            DA4_OpTrial = DA4_OpTrial+1;
        end
        DisAvr5_action = DisAvr5.chooseAction();
        [result, whole_result] = env.step(DisAvr5_action);
        DisAvr5_reward = DisAvr5_reward + result;
        DisAvr5.updateAgent(whole_result);
        if DisAvr5_action == FIBA_action
            DA5_OpTrial = DA5_OpTrial+1;
        end
        % CABk
        CABk1_action = CABk1.chooseAction();
        [result, whole_result] = env.step(CABk1_action);
        CABk1_reward = CABk1_reward + result;
        CABk1.updateAgent(whole_result);
        if CABk1_action == FIBA_action
            CABk1_OpTrial = CABk1_OpTrial+1;
        end
        CABk2_action = CABk2.chooseAction();
        [result, whole_result] = env.step(CABk2_action);
        CABk2_reward = CABk2_reward + result;
        CABk2.updateAgent(whole_result);
        if CABk2_action == FIBA_action
            CABk2_OpTrial = CABk2_OpTrial+1;
        end
        CABk3_action = CABk3.chooseAction();
        [result, whole_result] = env.step(CABk3_action);
        CABk3_reward = CABk3_reward + result;
        CABk3.updateAgent(whole_result);
        if CABk3_action == FIBA_action
            CABk3_OpTrial = CABk3_OpTrial+1;
        end
        CABk4_action = CABk4.chooseAction();
        [result, whole_result] = env.step(CABk4_action);
        CABk4_reward = CABk4_reward + result;
        CABk4.updateAgent(whole_result);
        if CABk4_action == FIBA_action
            CABk4_OpTrial = CABk4_OpTrial+1;
        end
        CABk5_action = CABk5.chooseAction();
        [result, whole_result] = env.step(CABk5_action);
        CABk5_reward = CABk5_reward + result;
        CABk5.updateAgent(whole_result);
        if CABk5_action == FIBA_action
            CABk5_OpTrial = CABk5_OpTrial+1;
        end
        CABk6_action = CABk6.chooseAction();
        [result, whole_result] = env.step(CABk6_action);
        CABk6_reward = CABk6_reward + result;
        CABk6.updateAgent(whole_result);
        if CABk6_action == FIBA_action
            CABk6_OpTrial = CABk6_OpTrial+1;
        end
    end
end

%% result computing
% optimal trial percent
FP_OpTrialPer = FP_OpTrial / (ProbNum*TrialNum);
DisAvr_OpTrialPer = [DA1_OpTrial / (ProbNum*TrialNum),DA2_OpTrial / (ProbNum*TrialNum),...
    DA3_OpTrial / (ProbNum*TrialNum),DA4_OpTrial / (ProbNum*TrialNum),DA5_OpTrial / (ProbNum*TrialNum)];
CABk_OpTrialPer = [CABk1_OpTrial / (ProbNum*TrialNum),CABk2_OpTrial / (ProbNum*TrialNum)...
    CABk3_OpTrial / (ProbNum*TrialNum),CABk4_OpTrial / (ProbNum*TrialNum),...
    CABk5_OpTrial / (ProbNum*TrialNum),CABk6_OpTrial / (ProbNum*TrialNum)];
% mean payoff
FIBA_MPayoff = mean(FIBA_reward);
FP_MPayoff = mean(FP_reward);
DisAvr_MPayoff = [mean(DisAvr1_reward),mean(DisAvr2_reward),mean(DisAvr3_reward),...
    mean(DisAvr4_reward),mean(DisAvr5_reward)];
CABk_MPayoff = [mean(CABk1_reward),mean(CABk2_reward),mean(CABk3_reward),...
    mean(CABk4_reward),mean(CABk5_reward),mean(CABk6_reward)];
fprintf('FP agent optimal trial percent = %f\n',FP_OpTrialPer);
fprintf('Discouted average agent optimal trial percent = %f\n',DisAvr_OpTrialPer);
fprintf('CABk agent optimal trial percent = %f\n',CABk_OpTrialPer);
fprintf('FIBA mean payoff = %f\n',FIBA_MPayoff);
fprintf('FP mean payoff = %f\n',FP_MPayoff);
fprintf('Discounted average mean payoff = %f\n',DisAvr_MPayoff);
fprintf('CABk mean payoff = %f\n',CABk_MPayoff);