%function [fitness] = getFitness(workload,pre,vmArrays)
function [fitness] = getFitness(workload,vmArrays)
    %fitness = 500 * getQos(workload,vmArrays) + getCost(pre,vmArrays)/8;
    fit = 0;
    sum = 0;
    for i = 0 : 5
        vm = vmArrays((i*3)+1:(i*3)+3);
        fit = getQos(workload,vm) + getCost(vm);
        sum = sum + fit;
    end
    fitness = sum / 6;
end