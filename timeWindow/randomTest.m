% �������Ÿ���ָ���������fitnessֵ
%�Ƚ�����������ԣ���������ڼ�¼��ǰ���Ե�workload��workload��Ӧ�ĵ�������ֵ
%pso�������������ͬ�ĵ�workload����ʵ��
%��¼����
%interval:�������䣬workloadNum:ѡȡ�ĸ��ص������pre:��ʼ���ã�isUpdate:�Ƿ�����workload������һ��ʵ��
function [result] = randomTest(interval,workloadNum,pre,timeWindowIndex)
    index = 1;
    p = 1;
    betterPoints = [];
    [workload,initPoint] = getWindowsData(timeWindowIndex);
    disp(initPoint);
    count = getCount(interval,initPoint);
    %���㵥�����ų�ʼfitnessֵ
    fitness = getFitness(workload,initPoint);
%     savePlan(workload,initPoint,fitness,workloadNum);
    t1 = clock;
    t2 = clock;
    while p < count && etime(t2,t1) < 180
        
        %��initPoint�����е��ƶ���2
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