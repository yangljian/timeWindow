function [result] = pso_ga(pre,timeWindowIndex)
    
    global N;
    global c1;
    global c2;
    global pBest;
    global gBest;
    global fitness;
    global iter;
    N = 100;
    iter = 100;
    pBest = [];
    gBest = [];
    fitness = [];
    %��ʼ����Ⱥ
    initPopulation();
    %��ȡ��ǰ����
    [workload,initPoint] = getWindowsData(timeWindowIndex);
    disp(initPoint);
    count = 1;
    t1=clock;
    t2=clock;
    while count <= iter && etime(t2,t1) <= 180
        %--����pbest��gbest--
        calPbestAndGbest(count,workload,pre);
        
        %--�Ƚ�����pBest����ȡ����pBest����������ΪgBest--
        index = getBestPBest();
        gBest = pBest(index,:);
        gBest(19) = fitness(index);
        
        %--ͨ���Ŵ��㷨�еĽ������������������ӵ�λ��--
        updateX();
        count = count + 1;
        t2 = clock;
    end
    temp = gBest(1:3) - pre;
    temp(temp<0) = 0;
    betterOne = pre + temp
    newPre = temp
    result = gBest;
%     disp(newPre);
%     disp(betterOne);
end

%��ʼ����Ⱥ�����ʼ��Ⱥ��СΪN
function initPopulation()
    global x;
    global v;
    global N;
    for i = 1 : N
        for j = 1 : 18
           x(i,j) = round(unifrnd(0,8));
        end
    end
end

function calPbestAndGbest(count,workload,pre)
    global N;
    global pBest;
    global gBest;
    global x;
    global fitness;
    %1.����ÿ����Ⱥ��fitnessֵ
        if(count == 1)
            %����ǵ�һ�ε�������ֱ�ӳ�ʼ��fitness������pBest����
            for i = 1:N
                newFitness = getFitness(workload,x(i,1:18));
                pBest(i,1:18) = x(i,1:18);
                fitness(i) = newFitness;
            end
        else
            %2.���������������1�ˣ��򽫼��������newFitnessֵ��fitness�Ƚϣ���С��fitness����
            for i = 1:N
                newFitness = getFitness(workload,x(i,1:18));
                if(newFitness < fitness(i))
                   fitness(i) = newFitness;
                   pBest(i,1:18) = x(i,1:18);
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
    %��ʼ������
    c1 = 0.5;
    c2 = 0.5;
    w = 0.5;
    %ѭ�������������ӣ����б��콻�����
    for i =1 : N
        %��ʼ�����������
       r1 = unifrnd(0,1);
       r2 = unifrnd(0,1);
       r3 = unifrnd(0,1);
       if(r1 > w)
           %�������
           mutates(i);
       end
       if(r2 > c1)
           %�������
           crossover(i,pBest(i,1:18));
       end
       if(r3 > c2)
           %�������
           crossover(i,gBest(1:18));
       end
    end
end
%�������
function mutates(flag)
    global x;
    %���ѡȡ���ӱ����һ����λ
    index = randperm(6,1);
    %��ʼ�������
    x(flag,3*(index-1)+1:3*(index-1)+3) = [round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8))];
end

%�������
function crossover(flag,point)
    global x;
    %ȷ�����������λ��
    cp = randperm(6,2);
    %�������
    x(flag,3*(cp(1)-1)+1:3*(cp(1)-1)+3) = point(3*(cp(1)-1)+1:3*(cp(1)-1)+3);
    x(flag,3*(cp(2)-1)+1:3*(cp(2)-1)+3) = point(3*(cp(2)-1)+1:3*(cp(2)-1)+3);
end