function [workloads,initPoints] = getAllWorkloadAndInitPoints(count,datas)
%     index = unidrnd(11,1,count);%��1-11�����ѡȡcount�����ص�
index=[2,3,5,9,10,9,4,6,1,2,3,2,3,3,3,3,3,3];
    for i = 1 : length(index)
       workloads(i,1:2) = datas(index(i),1:2);
       initPoints(3*(i-1)+1:3*(i-1)+3) = datas(index(i),3:5);
    end
    %�����ص����ʼ���ó־û�
     save('workloads','workloads');
     save('initPoints','initPoints');
end