
function [result] = psoTest()
    global N;
    global c1;
    global c2;
    global x;
    global v;
    global pBest;
    global gBest;
    global fitness;
    N = 100;
    c1 = 2;
    c2 = 2;
    iter = 100;
    pBest = [];
    gBest = [];
    fitness = [];
    initPopulation();
    workload  = [11.25,0.25;12.5,0.25;13.75,0.35;15,0.15;16.25,0.45;17.5,0.15];
    count = 1;
    while count <= iter
        %--����--
        %1.����ÿ����Ⱥ��fitnessֵ
        for i = 1:N
           newFitness = getFitness(workload,[0,2,5],x(i,1:18));
           %����ǵ�һ�ε�������ֱ�ӳ�ʼ��fitness������pBest����
           if(count == 1)
               pBest(i,1:18) = x(i,1:18);
               fitness(i) = newFitness;
               continue;
           end
           %2.���������������1�ˣ��򽫼��������newFitnessֵ��fitness�Ƚϣ���С��fitness����
           if(newFitness < fitness(i))
               fitness(i) = newFitness;
               pBest(i,1:18) = x(i,1:18);
           end
        end
        %3.�Ƚ�����pBest����ȡ����pBest����������ΪgBest
        index = getBestPBest(fitness);
        gBest = pBest(index,:);
        
        %--����--
        %1.���ݸ��¹�ʽ�����µ�v��x
        updateV();
        updateX();
        %2.Լ��Խ��ĵ�
        count = count + 1;
    end
    result = gBest;

end


%��ʼ����Ⱥ�����ʼ��Ⱥ��СΪN
function initPopulation()
    global x;
    global v;
    global N;
    for i = 1 : N
        x(i,1:18) = [round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8))];
        v(i,1:18) = [round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8)),round(unifrnd(-8,8))];
    end
end

function [index] = getBestPBest(fitness)
    global N;
    result = fitness(1);
    index = 1;
    for i = 1 : N-1
        if(result > fitness(i+1))
            result = fitness(i+1);
            index = i+1;
        end
    end
end

function updateV()
    global N;
    global c1;
    global c2;
    global x;
    global v;
    global pBest;
    global gBest;
    count = 1;
    while count <= N
        temp1 = unifrnd(0,1);
        temp2 = unifrnd(0,1);
        v(count,1:18) = 0.5*v(count,1:18) + c1*temp1*(pBest(count,1:18)-x(count,1:18)) + c2*temp2*(gBest(1:18)-x(count,1:18));
        count = count + 1;
    end
end
function updateX()
    global x;
    global v;
    global N;
    %����λ��ֵ
    x = x + v;
    %�߽�Լ�����������0-8��Χ������Ҫ����
    for i = 1 : N
        for j = 1 : 18
           if(x(i,j) < 0)
               x(i,j) = 0;
           elseif(x(i,j) > 8)
               x(i,j) = 8;
           end
        end
    end
end

function w = getW(gBest)
    
end

