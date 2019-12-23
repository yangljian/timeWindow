function [workloads,initPoints] = getWorkloadAndInitPointsByTimeWindowIndex(timeWindowIndex)
    workloadTemp = load('workloads.mat');
    initPointsTemp = load('initPoints.mat');
    workloads(1:6,1:2) = workloadTemp.workloads(timeWindowIndex:timeWindowIndex+5,1:2);
    initPoints(1:18) = initPointsTemp.initPoints(3*(timeWindowIndex-1)+1:3*(timeWindowIndex-1)+18);
end