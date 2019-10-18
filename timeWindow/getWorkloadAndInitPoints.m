function [workload,singleBetterPoint] = getWorkloadAndInitPoints(count,datas)
    index = randi(11,1,count);%从1-11中随机选取count个负载点
    for i = 1 : count
       workload(i,1:2) = datas(index(i),1:2);
       singleBetterPoint(3*(i-1)+1:3*(i-1)+3) = datas(index(i),3:5);
    end
end