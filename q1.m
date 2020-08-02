clc
clear all
titles = {'average_waiting_time','probability_of_wait',...
    'probability_idle','probability_busy','average_service_time',...
    'average_time_between_arrivales','average_time_of_queued_customers',...
    'average_time_spending_in_system'};
res = [];
for i=[1:5]
    res1 =grocery_stor_simulator(20);
    res = [res ; res1];
end

 sTable = array2table(res,'VariableNames',titles);