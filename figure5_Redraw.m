hold on;
line_settings = {'-', '-', '-', '-.', '--', '--', '--'};
pictures = [2 5 6 7 9 10 13];
for i = 1:7
    plot(1:5, proportion(:, pictures(i)), line_settings{i}, 'LineWidth', 3);
end
xlabel('Variability Level');
ylabel('Prop. Optimal Trials')
set(gca,'xtick',1:5);
set(gca,'ytick',0.5:0.1:1);
legend('\alpha = 0.25', '\alpha = 0.5', '\alpha = 0.75', 'FP', 'CAB-1', 'CAB-2', 'CAB-5');