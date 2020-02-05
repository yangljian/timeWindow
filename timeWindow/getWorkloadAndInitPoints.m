function [workloads,initPoints] = getAllWorkloadAndInitPoints(count,datas)
%     index = unidrnd(11,1,count);%从1-11中随机选取count个负载点
index=[2,3,5,9,10,9,4,6,1,2,3,2,3,3,3,3,3,3];
    for i = 1 : length(index)
       workloads(i,1:2) = datas(index(i),1:2);
       initPoints(3*(i-1)+1:3*(i-1)+3) = datas(index(i),3:5);
    end
    %将负载点与初始配置持久化
     save('workloads','workloads');
     save('initPoints','initPoints');
end