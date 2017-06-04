hold on;
line_settings = {'-', '-', '-', '-.', '--', '--', '--'};
pictures = [2 5 6 7 9 10 13];
for i = 1:7
    plot(1:5, proportion(:, pictures(i)), line_settings{i},'LineWidth', 3);
end
legend('FP', '\alpha = 0.25', '\alpha = 0.5', '\alpha = 0.75','CAB-1','CAB-2','CAB-5');