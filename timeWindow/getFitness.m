function [fitness] = getFitness(workload,pre,vmArrays)
    fitness = 500 * getQos(workload,vmArrays) + getCost(pre,vmArrays)/8;
end