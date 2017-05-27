clc; clear; close all; fclose all;
%%
addpath(genpath('../Gambler/agent'));
addpath(genpath('../Gambler/env'));

ProbNum = 20;
TrialNum = 100; % Trial Number should take 50000 and 100 seperately
payment = [];% Record the payment of each agents at 10000 problems
pGainAll = [];% Record the pGain of 10000 problems at each trails
pGainRate = [];% Record the pGain changing rate of 10000 problems
relativePayment = [];% Record the relative performance of each agents at 10000 problems

for prob = 1:ProbNum
    % set up env
    Vgain = randi([1, 20]);
    Vloss = randi([-20, -1]);
    state = 4;
    transition = zeros(state, state);
    for row = 1:state
        column = randi([1, state]);
        unique = 1 - rand() / state;
        transition(row, :) = (1 - unique) / (state - 1);
        transition(row, column) = unique;
    end
    env = TwoOptionsEnv(state, Vgain, Vloss, transition);
    pGain = [];

    % % agent setting
    FIBA = FIBAgent(Vgain, Vloss, transition);
    FP = DisAvrAgent(1);
    DisAvr1 = DisAvrAgent(0);
    DisAvr2 = DisAvrAgent(0.25);
    DisAvr3 = DisAvrAgent(0.5);
    DisAvr4 = DisAvrAgent(0.75);
    DisAvr5 = DisAvrAgent(0.9);
    CABk1 = CABKAgent(1);
    CABk2 = CABKAgent(2);
    CABk3 = CABKAgent(3);
    CABk4 = CABKAgent(4);
    CABk5 = CABKAgent(5);
    CABk6 = CABKAgent(6);
%     FIBA_reward = [];
%     FP_reward = []; DisAvr1_reward = []; DisAvr2_reward = [];
%     DisAvr3_reward = []; DisAvr4_reward = []; DisAvr5_reward = [];
%     CABk1_reward = []; CABk2_reward = []; CABk3_reward = [];
%     CABk4_reward = []; CABk5_reward = []; CABk6_reward = [];
    FIBA_reward = 0;
    FP_reward = 0; DisAvr1_reward = 0; DisAvr2_reward = 0;
    DisAvr3_reward = 0; DisAvr4_reward = 0; DisAvr5_reward = 0;
    CABk1_reward = 0; CABk2_reward = 0; CABk3_reward = 0;
    CABk4_reward = 0; CABk5_reward = 0; CABk6_reward = 0;


    for trial = 1:TrialNum
        % % FIBA
        FIBA_action = FIBA.chooseAction();
        [result, whole_result] = env.getResult(FIBA_action);
%         FIBA_reward = [FIBA_reward, result];
        FIBA_reward = FIBA_reward + result;
        FIBA.updateAgent(whole_result);
        pGain = [pGain; FIBA.probability(1)+FIBA.probability(2)];
        % % FP
        FP_action = FP.chooseAction();
        [result, whole_result] = env.getResult(FP_action);
%         FP_reward = [FP_reward, result];
        FP_reward = FP_reward + result;
        FP.updateAgent(whole_result);
%         if FP_action == FIBA_action
%             FP_OpTrial = FP_OpTrial+1;
%         end
        % % DisAvr
        DisAvr1_action = DisAvr1.chooseAction();
        [result, whole_result] = env.getResult(DisAvr1_action);
%         DisAvr1_reward = [DisAvr1_reward, result];
        DisAvr1_reward = DisAvr1_reward + result;
        DisAvr1.updateAgent(whole_result);
%         if DisAvr1_action == FIBA_action
%             DA1_OpTrial = DA1_OpTrial+1;
%         end
        DisAvr2_action = DisAvr2.chooseAction();
        [result, whole_result] = env.getResult(DisAvr2_action);
%         DisAvr2_reward = [DisAvr2_reward, result];
        DisAvr2_reward = DisAvr1_reward + result;
        DisAvr2.updateAgent(whole_result);
%         if DisAvr2_action == FIBA_action
%             DA2_OpTrial = DA2_OpTrial+1;
%         end
        DisAvr3_action = DisAvr3.chooseAction();
        [result, whole_result] = env.getResult(DisAvr3_action);
%         DisAvr3_reward = [DisAvr3_reward, result];
        DisAvr3_reward = DisAvr1_reward + result;
        DisAvr3.updateAgent(whole_result);
%         if DisAvr3_action == FIBA_action
%             DA3_OpTrial = DA3_OpTrial+1;
%         end
        DisAvr4_action = DisAvr4.chooseAction();
        [result, whole_result] = env.getResult(DisAvr4_action);
%         DisAvr4_reward = [DisAvr4_reward, result];
        DisAvr4_reward = DisAvr1_reward + result;
        DisAvr4.updateAgent(whole_result);
%         if DisAvr4_action == FIBA_action
%             DA4_OpTrial = DA4_OpTrial+1;
%         end
        DisAvr5_action = DisAvr5.chooseAction();
        [result, whole_result] = env.getResult(DisAvr5_action);
%         DisAvr5_reward = [DisAvr5_reward, result];
        DisAvr5_reward = DisAvr1_reward + result;
        DisAvr5.updateAgent(whole_result);
%         if DisAvr5_action == FIBA_action
%             DA5_OpTrial = DA5_OpTrial+1;
%         end
        % % CABk
        CABk1_action = CABk1.chooseAction();
        [result, whole_result] = env.getResult(CABk1_action);
%         CABk1_reward = [CABk1_reward, result];
        CABk1_reward = CABk1_reward + result;
        CABk1.updateAgent(whole_result);
%         if CABk1_action == FIBA_action
%             CABk1_OpTrial = CABk1_OpTrial+1;
%         end
        CABk2_action = CABk2.chooseAction();
        [result, whole_result] = env.getResult(CABk2_action);
%         CABk2_reward = [CABk2_reward, result];
        CABk2_reward = CABk1_reward + result;
        CABk2.updateAgent(whole_result);
%         if CABk2_action == FIBA_action
%             CABk2_OpTrial = CABk2_OpTrial+1;
%         end
        CABk3_action = CABk3.chooseAction();
        [result, whole_result] = env.getResult(CABk3_action);
%         CABk3_reward = [CABk3_reward, result];
        CABk3_reward = CABk1_reward + result;
        CABk3.updateAgent(whole_result);
%         if CABk3_action == FIBA_action
%             CABk3_OpTrial = CABk3_OpTrial+1;
%         end
        CABk4_action = CABk4.chooseAction();
        [result, whole_result] = env.getResult(CABk4_action);
%         CABk4_reward = [CABk4_reward, result];
        CABk4_reward = CABk1_reward + result;
        CABk4.updateAgent(whole_result);
%         if CABk4_action == FIBA_action
%             CABk4_OpTrial = CABk4_OpTrial+1;
%         end
        CABk5_action = CABk5.chooseAction();
        [result, whole_result] = env.getResult(CABk5_action);
%         CABk5_reward = [CABk5_reward, result];
        CABk5_reward = CABk1_reward + result;
        CABk5.updateAgent(whole_result);
%         if CABk5_action == FIBA_action
%             CABk5_OpTrial = CABk5_OpTrial+1;
%         end
        CABk6_action = CABk6.chooseAction();
        [result, whole_result] = env.getResult(CABk6_action);
%         CABk6_reward = [CABk6_reward, result];
        CABk6_reward = CABk1_reward + result;
        CABk6.updateAgent(whole_result);
%         if CABk6_action == FIBA_action
%             CABk6_OpTrial = CABk6_OpTrial+1;
%         end
    end
    
    % % Record all payment during 10000 problems
%     payment = [payment; {FIBA_reward, FP_reward, DisAvr1_reward, DisAvr2_reward,...
%         DisAvr3_reward, DisAvr4_reward, DisAvr5_reward, CABk1_reward,...
%         CABk2_reward, CABk3_reward, CABk4_reward, CABk5_reward, CABk6_reward}];
    payment = [payment; {FP_reward, DisAvr2_reward,...
        DisAvr3_reward, DisAvr4_reward, CABk1_reward,...
        CABk2_reward, CABk5_reward}];

    % % Changing rate of pGain and all pGain 
    pGainAll = [pGainAll; pGain'];
    relativePayment = [relativePayment; fun_relativeRatio(cell2mat(payment(end,:)))];
    pGainRate = [pGainRate; mean(abs(diff(pGain)))];
    
end
%%
    % % 
    % % Separate the pGainRate into 10 decile
    [s_pGainRate,index_pGainRate] = sort(pGainRate);
    decileGroup = reshape(index_pGainRate, [], 10);
    decileResult = [];
    for decile = 1:1:10
        decileResult = [decileResult; mean(relativePayment(decileGroup(:,decile),:),1)];
    end

%% plot
cmp = colormap(lines(7));
figure1 = figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperSize',[8.5 11]*2.54,...
    'PaperPosition',[0.5 1 6.5 9]*2.54,'visible','on');

ax1 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.2 0.65 0.6 0.25]);
hold on;

p1 = plot(decileResult(:,1),'-','color',cmp(1,:),'linewidth',2);
p2 = plot(decileResult(:,2),'-','color',cmp(2,:),'linewidth',2);
p3 = plot(decileResult(:,3),'-','color',cmp(3,:),'linewidth',2);
p4 = plot(decileResult(:,4),'-','color',cmp(4,:),'linewidth',2);
p5 = plot(decileResult(:,5),'-','color',cmp(5,:),'linewidth',2);
p6 = plot(decileResult(:,6),'-','color',cmp(6,:),'linewidth',2);
p7 = plot(decileResult(:,7),'-','color',cmp(7,:),'linewidth',2);

l1 = legend([p1 p2 p3 p4 p5 p6 p7],'FP','\alpha = 0.25','\alpha = 0.5','\alpha = 0.75','CAB-1','CAB-2','CAB-3');
set(l1,'location','eastoutside','box','off');

ylim([0 1]);
xlim([1 10]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:1:10],'ytick',[0:0.2:1]);
plot([1 10 10],[1 1 0],'-k','linewidth',1);
xlabel('Decile');
ylabel('Relative Performance');
title([num2str(TrialNum), ' Trails'],'FontName','Times New Roman','Fontsize',10);

ax2 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.05 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(decileGroup(1,2),:),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:10:TrialNum],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
ylabel('pGain');
title('2nd Decile','FontName','Times New Roman','Fontsize',10);

ax3 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.3 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(decileGroup(1,4),:),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:10:TrialNum],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('4nd Decile','FontName','Times New Roman','Fontsize',10);

ax4 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.55 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(decileGroup(1,6),:),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:10:TrialNum],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('6nd Decile','FontName','Times New Roman','Fontsize',10);

ax5 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.80 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(decileGroup(1,8),:),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:10:TrialNum],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('8nd Decile','FontName','Times New Roman','Fontsize',10);

fn='fig_6';
print('-cmyk', '-dpsc2', [fn,'.eps']);
% print('-cmyk', '-dpng', [fn,'.png']);
print('-cmyk', '-dpdf', [fn,'.pdf']);