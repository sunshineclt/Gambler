clc; clear; close all; fclose all;

addpath(genpath('../Gambler/agent'));
addpath(genpath('../Gambler/env'));
%% load data
load fig_6_T100_P10000.mat
%% plot area
%%
%     % % Changing rate of all pGain 
%     relativePayment = [relativePayment; fun_relativeRatio(cell2mat(payment(end,:)))];
%     pGainRate = [pGainRate; mean(abs(diff(pGain)))];
% 
%     % % 
%     % % Separate the pGainRate into 10 decile
%     [s_pGainRate,index_pGainRate] = sort(pGainRate);
%     decileGroup = reshape(index_pGainRate, [], 10);
%     decileResult = [];
%     for decile = 1:1:10
%         decileResult = [decileResult; mean(relativePayment(decileGroup(:,decile),:),1)];
%     end

%% plot
TrialNum = 100;

cmp = colormap(lines(7));
figure1 = figure('PaperType','usletter',...
    'PaperPositionMode','manual','PaperSize',[8.5 11]*2.54,...
    'PaperPosition',[0.5 1 6.5 9]*2.54,'visible','on');

ax1 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.2 0.65 0.6 0.25]);
hold on;

p1 = plot(relativeRewards(:,1),'-','color',cmp(1,:),'linewidth',2);
p2 = plot(relativeRewards(:,2),'-','color',cmp(2,:),'linewidth',2);
p3 = plot(relativeRewards(:,3),'-','color',cmp(3,:),'linewidth',2);
p4 = plot(relativeRewards(:,4),'-','color',cmp(4,:),'linewidth',2);
p5 = plot(relativeRewards(:,5),'-','color',cmp(5,:),'linewidth',2);
p6 = plot(relativeRewards(:,6),'-','color',cmp(6,:),'linewidth',2);
p7 = plot(relativeRewards(:,7),'-','color',cmp(7,:),'linewidth',2);

l1 = legend([p1 p2 p3 p4 p5 p6 p7],'FP','\alpha = 0.25','\alpha = 0.5','\alpha = 0.75','CAB-1','CAB-2','CAB-3');
set(l1,'location','eastoutside','box','off');

ylim([0.5 1]);
xlim([1 10]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[1:1:10],'ytick',[0.5:0.1:1]);
plot([1 10 10],[1 1 0.5],'-k','linewidth',1);
xlabel('Decile');
ylabel('Relative Performance');
title('100 Trails','FontName','Times New Roman','Fontsize',10);

ax2 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.05 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(randi([1, 10000]), :, 2),'-k','linewidth',1);
ylim([0 1]);
xlim([1 100]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[20:20:100],'ytick',[0:0.2:1]);
plot([1 100 100],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
ylabel('pGain');
title('2nd Decile','FontName','Times New Roman','Fontsize',10);

ax3 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.3 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(randi([1, 10000]), :, 4),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[20:20:100],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('4nd Decile','FontName','Times New Roman','Fontsize',10);

ax4 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.55 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(randi([1, 10000]), :, 6),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[20:20:100],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('6nd Decile','FontName','Times New Roman','Fontsize',10);

ax5 = axes('Parent',figure1,'LineWidth',1,...
     'Layer','top','FontSize',10,'box','off','color','none',...
     'YAxisLocation','left','position',[0.80 0.45 0.2 0.12]);
hold on;
p1 = plot(pGainAll(randi([1, 10000]), :, 8),'-k','linewidth',1);
ylim([0 1]);
xlim([1 TrialNum]);
set(gca,'FontName','Times New Roman','TickDir','out',...
    'xscale','lin','yscale','lin','xminortick','off','yminortick','off',...
    'TickLength',[0.01 0.025]);
set(gca,'xtick',[20:20:100],'ytick',[0:0.2:1]);
plot([1 TrialNum TrialNum],[1 1 0],'-k','linewidth',1);
xlabel('Trials');
% ylabel('pGain');
title('8nd Decile','FontName','Times New Roman','Fontsize',10);

fn='fig_6_T100';
print('-cmyk', '-dpsc2', [fn,'.eps']);
% print('-cmyk', '-dpng', [fn,'.png']);
print('-cmyk', '-dpdf', [fn,'.pdf']);