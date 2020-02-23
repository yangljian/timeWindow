% 单点最优附近指定区间计算fitness值
%先进行随机法测试，在随机法内记录当前测试的workload与workload对应的单点最优值
%pso传入与随机法相同的的workload进行实验
%记录数据
%interval:浮动区间，workloadNum:选取的负载点个数，pre:初始配置，isUpdate:是否重置workload进行下一轮实验
function [betterAddPoints] = randomTest(interval,t)
    addpath(genpath('E:\时间窗口实验\timeWindow\datas'));
    addpath(genpath('E:\时间窗口实验\timeWindow\randomTest\util'));
    load('E:\时间窗口实验\timeWindow\datas\randomPlan.mat','randomPlan');
    load('E:\时间窗口实验\timeWindow\datas\randomAddPlan.mat','randomAddPlan');
    global length;
    index = 1;
    length = 3;
    p = 1;
    betterAddPoints = [];
    %获取时刻t对应的窗口内负载情况以及单点最优配置
    [workload,windowPoint] = getWindowsData(t,length);
    disp(workload);
    %通过单点最优配置，计算出对应的增加虚拟机配置方案，供后续随机法实验
    addVMPlan = getAddPlan(windowPoint,length,t,randomAddPlan);
    %计算随机方案的个数
    count = getCount(interval,addVMPlan);
    %根据增加虚拟机方案计算单点最优初始fitness值
   
    [fitness,addVMPlan] = getTimeWindowFitness(workload,addVMPlan,t,randomAddPlan);
    
%     savePlan(workload,initPoint,fitness,workloadNum);
    t1 = clock;
    t2 = clock;
    while (p < count && etime(t2,t1) <= 60) || isempty(betterAddPoints)
        
        %将initPoint的所有点移动±2
        newPoints = getNewPoints(interval,windowPoint);
        newAddVMPlan = getAddPlan(newPoints,length,t,randomAddPlan);
        [newFitness,newPoints] = getTimeWindowFitness(workload,newAddVMPlan,t,randomAddPlan);
        if(newFitness < fitness)
            fitness = newFitness;
            betterAddPoints(index,1:length*3) = newAddVMPlan;
            betterAddPoints(index,length*3+1) = newFitness;
            index = index + 1;
        end
         p = p + 1;
         t2 = clock;
    end
    [p,q] = size(betterAddPoints);
    saveDatas(betterAddPoints(p,1:length*3+1),"random",t);
end
