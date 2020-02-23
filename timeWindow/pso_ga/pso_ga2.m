function pso_ga2(t)
    addpath(genpath('E:\ʱ�䴰��ʵ��\timeWindow\datas'));
    addpath(genpath('E:\ʱ�䴰��ʵ��\timeWindow\randomTest\util'));
    load('E:\ʱ�䴰��ʵ��\timeWindow\datas\psoGaPlan.mat','psoGaPlan');
    load('E:\ʱ�䴰��ʵ��\timeWindow\datas\psoGaAddPlan.mat','psoGaAddPlan');
    global length;
    global N;
    global pBest;
    global gBest;
    global fitness;
    global iter;
    length = 3;
    N = 10;
    iter = 100;
    pBest = [];
    gBest = [];
    fitness = [];
    %��ʼ����Ⱥ
    initPopulation();
    %��ȡ��ǰ����
    [workload,windowPoint] = getWindowsData(t,length);
    disp(workload);
    count = 1;
    t1=clock;
    t2=clock;
    while count <= iter && etime(t2,t1) <= 60
        %--����pbest��gbest--
        calPbest(count,workload,t,psoGaAddPlan);
        
        %--�Ƚ�����pBest����ȡ����pBest����������ΪgBest--
        index = getBestPBest();
        gBest = pBest(index,:);
        gBest(length*3+1) = fitness(index);
        
        %--ͨ���Ŵ��㷨�еĽ������������������ӵ�λ��--
        updateX();
        count = count + 1;
        t2 = clock;
    end
    saveDatas(gBest,"psoGa",t);
end

%��ʼ����Ⱥ�����ʼ��Ⱥ��СΪN
function initPopulation()
    global x;
    global N;
    global length;
    %x = [];
    for i = 1 : N
        for j = 1 : length*3
%             if(mod(j,3) == 1)
%                 x(i,j) = 0;
%             else
%                 x(i,j) = round(unifrnd(0,4));
%             end
            x(i,j) = round(unifrnd(0,4));
        end
    end
end

function calPbest(count,workload,t,psoGaAddPlan)
    global N;
    global pBest;
    global x;
    global fitness;
    global length;
    size = length*3;
    %1.����ÿ����Ⱥ��fitnessֵ
        if(count == 1)
            %����ǵ�һ�ε�������ֱ�ӳ�ʼ��fitness������pBest����
            for i = 1:N
                [newFitness,x(i,1:size)] = getTimeWindowFitness(workload,x(i,1:size),t,psoGaAddPlan);
                pBest(i,1:size) = x(i,1:size);
                fitness(i) = newFitness;
            end
        else
            %2.���������������1�ˣ��򽫼��������newFitnessֵ��fitness�Ƚϣ���С��fitness����
            for i = 1:N
                [newFitness,x(i,1:size)] = getTimeWindowFitness(workload,x(i,1:size),t,psoGaAddPlan);
                if(newFitness < fitness(i))
                   fitness(i) = newFitness;
                   pBest(i,1:size) = x(i,1:size);
                end
            end
        end
end

function [index] = getBestPBest()
    global N;
    global fitness;
    result = fitness(1);
    index = 1;
    for i = 1 : N-1
        if(result > fitness(i+1))
            result = fitness(i+1);
            index = i+1;
        end
    end
end

function updateX()
    global N;
    global c1;
    global c2;
    global w;
    global pBest;
    global gBest;
    global length;
    size = length*3;
    %��ʼ������
    c1 = 0.5;
    c2 = 0.5;
    w = 0.5;
    %ѭ�������������ӣ����б��콻�����
    for i =1 : N
        %��ʼ�����������
       r = [unifrnd(0,1),unifrnd(0,1),unifrnd(0,1)];
       if(r(1) > w)
           %�������
           mutates(i);
       end
       if(r(2) > c1)
           %�������
           crossover(i,pBest(i,1:size));
       end
       if(r(3) > c2)
           %�������
           crossover(i,gBest(1:size));
       end
    end
end
%�������
function mutates(flag)
    global x;
    global length;
    %���ѡȡ���ӱ����һ����λ
    index = randperm(length,1);
    %��ʼ�������
    x(flag,3*(index-1)+1:3*(index-1)+3) = [round(unifrnd(0,4)),round(unifrnd(0,4)),round(unifrnd(0,4))];
end

%�������
function crossover(flag,point)
    global x;
    global length;
    %ȷ�����������λ��
    cp = randperm(length,2);
    %�������
    x(flag,3*(cp(1)-1)+2:3*(cp(1)-1)+3) = point(3*(cp(1)-1)+2:3*(cp(1)-1)+3);
    x(flag,3*(cp(2)-1)+2:3*(cp(2)-1)+3) = point(3*(cp(2)-1)+2:3*(cp(2)-1)+3);
end