function [result,workload] = psoTest(pre)
    t1=clock;
    global N;
    global c1;
    global c2;
    global x;
    global v;
    global pBest;
    global gBest;
    global fitness;
    global iter;
    N = 100;
    c1 = 2;
    c2 = 2;
    iter = 100;
    pBest = [];
    gBest = [];
    fitness = [];
    initPopulation();
    load('workload.mat','workload');
    count = 1;
    t2=clock;
    while count <= iter && etime(t2,t1) <= 180
        %--����pbest��gbest--
        calPbestAndGbest(count,workload,pre);
        
        %--�Ƚ�����pBest����ȡ����pBest����������ΪgBest--
        index = getBestPBest();
        gBest = pBest(index,:);
        gBest(19) = fitness(index);
        
        %--���������ٶ���λ��--
        updateVAndX();
        count = count + 1;
        t2 = clock;
    end
    result = gBest;
    
end

%��ʼ����Ⱥ�����ʼ��Ⱥ��СΪN
function initPopulation()
    global x;
    global v;
    global N;
    for i = 1 : N
        for j = 1 : 18
           x(i,j) = round(unifrnd(0,8));
           v(i,j) = round(unifrnd(-8,8));
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
                newFitness = getFitness(workload,pre,x(i,1:18));
                pBest(i,1:18) = x(i,1:18);
                fitness(i) = newFitness;
            end
        else
            %2.���������������1�ˣ��򽫼��������newFitnessֵ��fitness�Ƚϣ���С��fitness����
            for i = 1:N
                newFitness = getFitness(workload,pre,x(i,1:18));
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

function updateVAndX()
    global N;
    global c1;
    global c2;
    global x;
    global v;
    global pBest;
    global gBest;
    count = 1;
    while count <= N
        v(count,1:18) = round(0.5*v(count,1:18) + c1*unifrnd(0,1)*(pBest(count,1:18)-x(count,1:18)) + c2*unifrnd(0,1)*(gBest(1:18)-x(count,1:18)));
        for i = 1 : 18
           if(v(count,i) > 8)
               v(count,i) = round(unifrnd(0,8));
           elseif(v(count,i) < -8)
               v(count,i) = round(unifrnd(-8,0));
           end
        end
        count = count + 1;
    end
    %����λ��ֵ
    x = x + v;
    %�߽�Լ�����������0-8��Χ������Ҫ����
  
    for i = 1 : N
        for j = 1 : 18
            if(x(i,j) < 0 || x(i,j) > 8)
               x(i,j) = round(unifrnd(0,8)); 
            end
        end
    end
end