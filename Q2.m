clc
clear vars
customers = 20 ;% number of customers

interarrival_distribution_of_cars = [1 2 3 4];
probability = [0.25 0.4 0.2 0.15];
interarrival_time = rng_pdf(interarrival_distribution_of_cars,probability,customers-1);
interarrival_time = [0 interarrival_time];
arrival_time = zeros(1,customers);
arrival_time(1)= 0;
titles={'customers','time between arrivals','arrival time',...
    'Able Begine','Able service time','Able end',...
    'Baker Begine','Baker service time','Baker end'};

Able = zeros(customers,3);
Able_service_time = [2 3 4 5];
Able_service_probability = [0.30 0.28 0.25 0.17];
Able_status = true;
Able_current_active_row = 1;

Baker = zeros(customers,3);
Baker_service_time = [3 4 5 6];
Baker_service_probability = [0.35 0.25 0.20 0.20];
Baker_status = true ;
Baker_current_active_row = 1 ;

wait_queue = [];

for i=[2:customers]
    arrival_time(i)=arrival_time(i-1)+interarrival_time(i);
end



for clock=[0:sum(arrival_time)]
    for a=[1:customers]
        if arrival_time(a) == clock
            wait_queue = [wait_queue a];
        end
    end
    
    if Able(Able_current_active_row,3) == clock 
        Able_status = true
        
    end
    if Baker(Baker_current_active_row,3) == clock 
        Baker_status = true
              
    end
    
    if ~isempty(wait_queue)
        if Able_status == true
            c = wait_queue(1);
            service_time = rng_pdf(Able_service_time,Able_service_probability,1);
            Able(c,:) = [clock , service_time , clock+service_time];
            Able_status =false; 
            Able_current_active_row = c;
            wait_queue(1)=[];
        end
        if Baker_status == true && ~isempty(wait_queue)
            c = wait_queue(1)
            service_time = rng_pdf(Baker_service_time,Baker_service_probability,1);
            Baker(c,:) = [clock , service_time , clock+service_time];
            Baker_status =false;
            Baker_current_active_row = c;
            wait_queue(1)=[];
        end
    end
    
%res=[[1:customers]',interarrival_time',arrival_time',Able,Baker];
%table=array2table(res,'VariableNames',titles)
end

res=[[1:customers]',interarrival_time',arrival_time',Able,Baker];
table=array2table(res,'VariableNames',titles)
