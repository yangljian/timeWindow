function [workloads,initPoints] = getWindowData(t,length)
    timeWindowIndex = t/30+1;
    workloadTemp = load('workloads.mat');
    initPointsTemp = load('initPoints.mat');
    workloads(1:length,1:2) = workloadTemp.workloads(timeWindowIndex:timeWindowIndex+5,1:2);
    initPoints(1:length*3) = initPointsTemp.initPoints(3*(timeWindowIndex-1)+1:3*(timeWindowIndex-1)+18);
end