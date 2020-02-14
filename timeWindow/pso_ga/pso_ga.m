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
    %初始化种群
    initPopulation();
    %获取当前负载
    [workload,initPoint] = getWindowsData(timeWindowIndex);
    disp(initPoint);
    count = 1;
    t1=clock;
    t2=clock;
    while count <= iter && etime(t2,t1) <= 180
        %--计算pbest与gbest--
        calPbestAndGbest(count,workload,pre);
        
        %--比较所有pBest，获取最优pBest，并将其作为gBest--
        index = getBestPBest();
        gBest = pBest(index,:);
        gBest(19) = fitness(index);
        
        %--通过遗传算法中的交叉与变异操作更新粒子的位置--
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

%初始化种群，设初始种群大小为N
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
    %1.计算每个种群的fitness值
        if(count == 1)
            %如果是第一次迭代，则直接初始化fitness数组与pBest数组
            for i = 1:N
                newFitness = getFitness(workload,x(i,1:18));
                pBest(i,1:18) = x(i,1:18);
                fitness(i) = newFitness;
            end
        else
            %2.如果迭代次数大于1了，则将计算出来的newFitness值与fitness比较，将小的fitness留下
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
    %初始化参数
    c1 = 0.5;
    c2 = 0.5;
    w = 0.5;
    %循环遍历所有粒子，进行变异交叉操作
    for i =1 : N
        %初始化三个随机数
       r1 = unifrnd(0,1);
       r2 = unifrnd(0,1);
       r3 = unifrnd(0,1);
       if(r1 > w)
           %变异操作
           mutates(i);
       end
       if(r2 > c1)
           %交叉操作
           crossover(i,pBest(i,1:18));
       end
       if(r3 > c2)
           %交叉操作
           crossover(i,gBest(1:18));
       end
    end
end
%变异操作
function mutates(flag)
    global x;
    %随机选取粒子变异的一个分位
    index = randperm(6,1);
    %开始变异操作
    x(flag,3*(index-1)+1:3*(index-1)+3) = [round(unifrnd(0,8)),round(unifrnd(0,8)),round(unifrnd(0,8))];
end

%交叉操作
function crossover(flag,point)
    global x;
    %确定交叉的两个位置
    cp = randperm(6,2);
    %交叉操作
    x(flag,3*(cp(1)-1)+1:3*(cp(1)-1)+3) = point(3*(cp(1)-1)+1:3*(cp(1)-1)+3);
    x(flag,3*(cp(2)-1)+1:3*(cp(2)-1)+3) = point(3*(cp(2)-1)+1:3*(cp(2)-1)+3);
end