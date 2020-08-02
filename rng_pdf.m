function [result] = rng_pdf(time,probability,N)
%INTER_ARRIVAL_TIME_GENERATOR Summary of this function goes here
%   Detailed explanation goes here

cumulative_probability = [0 cumsum(probability)];
random_times = rand(1,N);
result = zeros(1,N);

for i =[1:N] 
    for j = [2:length(cumulative_probability)]
        if random_times(i)< cumulative_probability(j) && random_times(i) >= cumulative_probability(j-1)
            result(i) = time(j-1);
            break
        elseif random_times(i) ==1 
            result(i) = time(length(time));
            break
        end        
    end
end

end

