function [result] = gaTest(t)
    %导入需要使用到的函数包
    addpath('E:\时间窗口实验\timeWindow\randomTest\util');
    %根据输入参数t来获取当前的负载
    workload = getWindowsData(t,1);
    global allPlan;
    disp(workload);
    q = 2;
    load('E:\时间窗口实验\timeWindow\datas\gaAddPlan.mat','gaAddPlan');
    %获取初始虚拟机配置
    preVM = getPre(q,gaAddPlan);
    %初始化可能的数据集，供后续模型计算
    allPlan = getAllPlan(preVM,workload);
    resultAddVM = [0,0,0];
    resultPlan = [];
    %calculate init fitness
    fitness = calFitness([workload,preVM]);
    resultPlan = fitness;
    t1 = clock;
    t2 = clock;
    while etime(t2,t1) <= 60 && ~isempty(allPlan)
        plan = getNewPlan();
        temp = calFitness(plan);
        if(temp(end) < resultPlan(end))
            resultPlan = temp;
            resultAddVM = temp(3:5) - preVM;
        end
        t2 = clock;
    end
    saveData(resultPlan,resultAddVM);
end

function [preVM] = getPre(q,gaAddPlan)
    preVM = [0,0,0];
    [m,n] = size(gaAddPlan);
    if(m == 0)
       return;
    elseif(m > 0)
       for i = m : -1 : m-q+2
           preVM = preVM + gaAddPlan(i,1:3);
       end
    end
end

function [allVMPlan] = getAllPlan(preVM,workload)
    small = preVM(1);
    middle = preVM(2);
    large = preVM(3);
    index = 0;
    for i = large : 8
        for j = middle : 8
            for k = small : 8
                index = index + 1;
                curr = preVM + [i,j,k];
                allVMPlan(index,1:5) = [workload,curr];
            end
        end
    end
                
end

function [addVM] = getNewPlan()
    global allPlan;
    [m,n] = size(allPlan);
    index = round(unifrnd(1,m));
    addVM = allPlan(index,:);
    allPlan(index,:) = [];
end

function [resultPlan] = calFitness(plan)
    global Model_svm_gaussian;
    c = predict(Model_svm_gaussian,plan);
    qos = sigmf(c,[-3.0 2.0]);
    cost = 17.61*plan(3) + 18.85*plan(4) + 20.84*plan(5);
    fit = 260/qos + cost/4;
    resultPlan = [plan,qos,cost,fit];
end