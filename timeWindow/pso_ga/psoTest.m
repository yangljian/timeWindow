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
        %--计算pbest与gbest--
        calPbestAndGbest(count,workload,pre);
        
        %--比较所有pBest，获取最优pBest，并将其作为gBest--
        index = getBestPBest();
        gBest = pBest(index,:);
        gBest(19) = fitness(index);
        
        %--更新粒子速度与位置--
        updateVAndX();
        count = count + 1;
        t2 = clock;
    end
    result = gBest;
    
end

%初始化种群，设初始种群大小为N
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
    %1.计算每个种群的fitness值
        if(count == 1)
            %如果是第一次迭代，则直接初始化fitness数组与pBest数组
            for i = 1:N
                newFitness = getFitness(workload,pre,x(i,1:18));
                pBest(i,1:18) = x(i,1:18);
                fitness(i) = newFitness;
            end
        else
            %2.如果迭代次数大于1了，则将计算出来的newFitness值与fitness比较，将小的fitness留下
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
    %更新位置值
    x = x + v;
    %边界约束，如果超出0-8范围，则需要调整
  
    for i = 1 : N
        for j = 1 : 18
            if(x(i,j) < 0 || x(i,j) > 8)
               x(i,j) = round(unifrnd(0,8)); 
            end
        end
    end
end