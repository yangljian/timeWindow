% �������Ÿ���ָ���������fitnessֵ
%�Ƚ�����������ԣ���������ڼ�¼��ǰ���Ե�workload��workload��Ӧ�ĵ�������ֵ
%pso�������������ͬ�ĵ�workload����ʵ��
%��¼����
%interval:�������䣬workloadNum:ѡȡ�ĸ��ص������pre:��ʼ���ã�isUpdate:�Ƿ�����workload������һ��ʵ��
function [betterAddPoints] = randomTest(interval,t)
    addpath(genpath('E:\ʱ�䴰��ʵ��\timeWindow\datas'));
    addpath(genpath('E:\ʱ�䴰��ʵ��\timeWindow\randomTest\util'));
    load('E:\ʱ�䴰��ʵ��\timeWindow\datas\randomPlan.mat','randomPlan');
    load('E:\ʱ�䴰��ʵ��\timeWindow\datas\randomAddPlan.mat','randomAddPlan');
    global length;
    index = 1;
    length = 3;
    p = 1;
    betterAddPoints = [];
    %��ȡʱ��t��Ӧ�Ĵ����ڸ�������Լ�������������
    [workload,windowPoint] = getWindowsData(t,length);
    disp(workload);
    %ͨ�������������ã��������Ӧ��������������÷����������������ʵ��
    addVMPlan = getAddPlan(windowPoint,length,t,randomAddPlan);
    %������������ĸ���
    count = getCount(interval,addVMPlan);
    %��������������������㵥�����ų�ʼfitnessֵ
   
    [fitness,addVMPlan] = getTimeWindowFitness(workload,addVMPlan,t,randomAddPlan);
    
%     savePlan(workload,initPoint,fitness,workloadNum);
    t1 = clock;
    t2 = clock;
    while (p < count && etime(t2,t1) <= 60) || isempty(betterAddPoints)
        
        %��initPoint�����е��ƶ���2
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
