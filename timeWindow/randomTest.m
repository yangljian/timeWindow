% 单点最优附近指定区间计算fitness值
%先进行随机法测试，在随机法内记录当前测试的workload与workload对应的单点最优值
%pso传入与随机法相同的的workload进行实验
%记录数据
%interval:浮动区间，workloadNum:选取的负载点个数，pre:初始配置，isUpdate:是否重置workload进行下一轮实验
function [betterPoints] = randomTest(interval,t)
    index = 1;
    length = 6;
    p = 1;
    betterPoints = [];
    betterOne = [];
    newPre = [];
    [workload,windowPoint] = getWindowsData(t,length);
    addVMPlan = getAddPlan(windowPoint,length,t);
    count = getCount(interval,addVMPlan);
    %计算单点最优初始fitness值
    fitness = getFitness2(workload,addVMPlan,t);
%     savePlan(workload,initPoint,fitness,workloadNum);
    t1 = clock;
    t2 = clock;
    while p < count && etime(t2,t1) <= 180
        
        %将initPoint的所有点移动±2
        newPoints = getNewPoints(interval,addVMPlan);
        newFitness = getFitness2(workload,newPoints,t);
        if(newFitness < fitness)
            fitness = newFitness;
            betterPoints(index,1:18) = newPoints;
            betterPoints(index,19) = newFitness;
            index = index + 1;
        end
         p = p + 1;
         t2 = clock;
    end
    disp(betterPoints);
%     [m,n] = size(betterPoints);
%     temp = betterPoints(m,1:3) - pre;
%     temp(temp<0) = 0;
%     betterOne = pre + temp
%     newPre = temp
end

function count = getCount(interval,vmArrays)
    count = 1;
    for i = 1:18
        if(vmArrays(i) >= interval && (4-vmArrays(i)) >= interval)
            count = count * (interval * 2);
        elseif(vmArrays(i) < interval)
            count = count * (interval + vmArrays(i));
        elseif((4 - vmArrays(i)) < interval)
            count = count * (interval + (4 - vmArrays(i)));
        end
    end
end

function temp = getNewPoints(interval,temp)
    for i = 1:18
        if(temp(i) >= interval && (4-temp(i)) >= interval)
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        elseif(temp(i) < interval)
            temp(i) = temp(i) + round(unifrnd(-temp(i),interval));
        elseif((4 - temp(i)) < interval)
            temp(i) = temp(i) + round(unifrnd(-interval,4-temp(i)));
        end
    end
end