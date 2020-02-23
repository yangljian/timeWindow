function [fitness,newAddVMArrays] = getTimeWindowFitness(workloads,addVMArrays,t,addPlan)
    addpath(genpath('E:\时间窗口实验\timeWindow\randomTest\util')); 
    addpath(genpath('E:\时间窗口实验\timeWindow\function')); 
    [vmArrays,newAddVMArrays] = getVmByAddVm(addVMArrays,t,addPlan);
    qos = getQoS(workloads,vmArrays);
    cost = getCost(addVMArrays);
    fitness = 900/qos + cost/6;
end

function [qosTotal] = getQoS(workloads,vmArrays)
    global Model_svm_gaussian;
    global length;
    temp = [];
    qosTotal = 0;
    for i = 1 : length
        temp = [workloads(i,1:2),vmArrays((i-1)*3+1:(i-1)*3+3)];
        c = predict(Model_svm_gaussian,temp);
        qos = sigmf(c,[-3.0 1.9]);
        qosTotal = qosTotal + qos;
    end
end

function [cost] = getCost(addVMArrays)
    small = 0;
    middle = 0;
    large = 0;
    global length;
    for i = 1 : length*3
       if(mod(i,3) == 1)
           small = small + addVMArrays(i);
       elseif(mod(i,3) == 2)
           middle = middle + addVMArrays(i);
       else
           large = large + addVMArrays(i);
       end
    end
    cost = 17.61*small + 18.85*middle + 20.84*large;
end