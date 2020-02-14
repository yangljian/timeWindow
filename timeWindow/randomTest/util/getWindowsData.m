function [workloads,initPoints] = getWindowData(t,length)
    timeWindowIndex = t/30+1;
    workloadTemp = load('E:\ʱ�䴰��ʵ��\timeWindow\datas\workloads.mat');
    initPointsTemp = load('E:\ʱ�䴰��ʵ��\timeWindow\datas\initPoints.mat');
    workloads(1:length,1:2) = workloadTemp.workloads(timeWindowIndex:timeWindowIndex+length-1,1:2);
    initPoints(1:length*3) = initPointsTemp.initPoints(3*(timeWindowIndex-1)+1:3*(timeWindowIndex-1)+length*3);
end