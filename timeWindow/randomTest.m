%单点最优附近指定区间计算fitness值
function result = randomTest(interval,initPoint)
    disp(initPoint);
    points = [];
    index = 1;
    workload  = [6.25,0.35;7.5,0.25;8.75,0.25;9.75,0.15;10,0.15;10.5,0.35];
    pre = [0,2,5];
    fitness = getFitness(workload,pre,initPoint);
    while index <= 100
        temp = initPoint;
        for i = 1:18
            %将initPoint的所有点移动±2
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        end
        %判断是否有负值以及是否超出最大虚拟机台数
        flag=~isempty(find(temp<0)) || ~isempty(find(temp>8));
        if(flag)
            continue;
        elseif(index == 1)%初始赋值
            points(index,1:18) = temp;
            points(index,19) = getFitness(workload,pre,temp);
            index = index + 1;
        else
           for j = 1:index-1
               %判断是否结果集中存在相同的方案
               if(isequal(points(j,:),temp))
                   flag = 1;
               end
           end
           if(~flag)%如果该方案是新的，则计算其fitness值
               newFitness = getFitness(workload,pre,temp);
               if(newFitness < fitness)%将fitness值小于单点最优方案的方案存入结果集中
                   fitness = newFitness;
                   points(index,1:18) = temp;
                   points(index,19) = newFitness;
                   index = index + 1;
               end
           end
        end
    end
end

function randomPoint = getOneRandom(interval,point)
    small = point(1);
    middle = point(2);
    large  = point(3);
    
end