function [res] = grocery_stor_simulator(N)
%clc
%clear all

%N = 20; % number of customers
customer=[1:N];
time_since_last_arrival = randi([1 8],1,N);
time_since_last_arrival(1)=0;
arrival_time = zeros(1,N);
queued_customers = 0;
for i=[2:N]
    arrival_time(i) = arrival_time(i-1)+time_since_last_arrival(i);
end
service_time = randi([1 6],1,N);
time_service_begines = zeros(1,N);
time_service_begines(1)=0;
time_service_ends = zeros(1,N);
time_service_ends(1)= service_time(1) ;

for i=[2:N]
   time_service_begines(i) = max(time_service_ends(i-1),arrival_time(i)); 
   time_service_ends(i) = time_service_begines(i) + service_time(i);
end
wait_queue_time = zeros(1,N);
idle_time = zeros(1,20);
idle_time(1)=0;
for i=[1:N]
    wait_queue_time(i)=time_service_begines(i)-arrival_time(i);
    if wait_queue_time(i)==0 && i >= 2
        idle_time(i) =  time_service_begines(i)-time_service_ends(i-1) ;
    else 
        idle_time(i) = 0;
    end
    if wait_queue_time(i)>0
        queued_customers = queued_customers + 1;
    end
    
end
total_system_time = zeros(1,N);
for i=[1:N]
    total_system_time(i)=time_service_ends(i)-arrival_time(i);
end



final_table=[customer' time_since_last_arrival' arrival_time' ...
    service_time' time_service_begines' time_service_ends' wait_queue_time' total_system_time' idle_time'];
sTable = array2table(final_table,'VariableNames',{'customer', 'time_since_last_arrival'...
    , 'arrival_time', 'service_time','time_service_begines','time_service_ends' ,'wait_queue_time','total_system_time','idle_time'});

average_waiting_time = sum(wait_queue_time)/N;
probability_of_wait = queued_customers / N;
probability_idle = sum(idle_time)/time_service_ends(N);
probability_busy = 1 - probability_idle;
average_service_time = sum(service_time)/N;
average_time_between_arrivales = arrival_time(N)/(N-1);
average_time_of_queued_customers = sum(wait_queue_time)/queued_customers;
average_time_spending_in_system = sum(total_system_time)/N;
res=[average_waiting_time,probability_of_wait,...
    probability_idle,probability_busy,average_service_time,...
    average_time_between_arrivales,average_time_of_queued_customers,...
    average_time_spending_in_system]
end

