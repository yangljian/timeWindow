function [fitness] = getFitness(workload,pre,vmArrays)
    fitness = 400 * getQos(workload,vmArrays) + getCost(pre,vmArrays)/6;
end