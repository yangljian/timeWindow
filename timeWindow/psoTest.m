
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
        %--计算--
        %1.计算每个种群的fitness值
        for i = 1:N
           newFitness = getFitness(workload,[0,2,5],x(i,1:18));
           %如果是第一次迭代，则直接初始化fitness数组与pBest数组
           if(count == 1)
               pBest(i,1:18) = x(i,1:18);
               fitness(i) = newFitness;
               continue;
           end
           %2.如果迭代次数大于1了，则将计算出来的newFitness值与fitness比较，将小的fitness留下
           if(newFitness < fitness(i))
               fitness(i) = newFitness;
               pBest(i,1:18) = x(i);
           end
        end
        %3.比较所有pBest，获取最优pBest，并将其作为gBest
        index = getBestPBest(fitness);
        gBest = pBest(index,:);
        
        %--更新--
        %1.根据更新公式计算新的v与x
        disp(v);
        updateV();
        disp(v);
%         x = updateX();
        %2.约束越界的点
        count = count + 1;
    end
    result = gBest;

end


%初始化种群，设初始种群大小为N
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
        v(count,1:18) = round(0.5*v(count,1:18) + c1*unifrnd(0,1)*(pBest(count,1:18)-x(count,1:18)) + c2*unifrnd(0,1)*(gBest(1:18)-x(count,1:18)));
        count = count + 1;
    end
end
function updateX()
end

function w = getW(gBest)
    
end

