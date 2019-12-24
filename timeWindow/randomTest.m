% 单点最优附近指定区间计算fitness值
%先进行随机法测试，在随机法内记录当前测试的workload与workload对应的单点最优值
%pso传入与随机法相同的的workload进行实验
%记录数据
%interval:浮动区间，workloadNum:选取的负载点个数，pre:初始配置，isUpdate:是否重置workload进行下一轮实验
function [result] = randomTest(interval,workloadNum,pre,timeWindowIndex)
    index = 1;
    p = 1;
    betterPoints = [];
    [workload,initPoint] = getWindowsData(timeWindowIndex);
    disp(initPoint);
    count = getCount(interval,initPoint);
    %计算单点最优初始fitness值
    fitness = getFitness(workload,initPoint);
%     savePlan(workload,initPoint,fitness,workloadNum);
    t1 = clock;
    t2 = clock;
    while p < count && etime(t2,t1) < 180
        
        %将initPoint的所有点移动±2
        temp = getNewPoints(interval,initPoint);
        newFitness = getFitness(workload,temp);
        if(newFitness < fitness)
            fitness = newFitness;
            betterPoints(index,1:18) = temp;
            betterPoints(index,19) = newFitness;
            index = index + 1;
        end
         p = p + 1;
         t2 = clock;
    end
    result = betterPoints;
end

function count = getCount(interval,initPoint)
    count = 1;
    for i = 1:18
        if(initPoint(i) >= interval && (8-initPoint(i)) >= interval)
            count = count * (interval * 2);
        elseif(initPoint(i) < interval)
            count = count * (interval + initPoint(i));
        elseif((8 - initPoint(i)) < interval)
            count = count * (interval + (8 - initPoint(i)));
        end
    end
end

function temp = getNewPoints(interval,temp)
    for i = 1:18
        if(temp(i) >= interval && (8-temp(i)) >= interval)
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        elseif(temp(i) < interval)
            temp(i) = temp(i) + round(unifrnd(-temp(i),interval));
        elseif((8 - temp(i)) < interval)
            temp(i) = temp(i) + round(unifrnd(-interval,8-temp(i)));
        end
    end
end

% function savePlan(workload,initPoint,fitness,workloadNum)
%     onePointsPlan = zeros(7,5);
%     onePointsPlan(1:6,1:2) = workload;
%     for i = 1 : workloadNum
%         onePointsPlan(i,3:5) = initPoint(3*(i-1)+1:3*(i-1)+3);
%     end
%     onePointsPlan(7,5) = fitness;
%     save('onePointsPlan.mat','onePointsPlan');
% end