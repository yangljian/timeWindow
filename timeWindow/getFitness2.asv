function [fitness] = getFitness2(workloads,addVMArrays,t)
    vmArrays = getVmByAddVm(addVMArrays,t);
    qos = getQoS(workloads,vmArrays);
    cost = getCost(addVMArrays);
    fitness = 250 * qos + cost/10;
end
function [vmArrays] = getVmByAddVm(addVMArrays,t)
    flag = 30;%  δt，间隔时间
    q = 60/flag;
    length = 6;%窗口长度
    preVM = pre(t,q);%时刻t的初始虚拟机配置
    for i = 1 : length
       addVM = [0,0,0];
       if(i <= q)
           for j = 1 : i
               addVM = addVM + addVMArrays((j-1)*3+1:(j-1)*3+3);
           end
           vmArrays((i-1)*3+1:(i-1)*3+3) = preVM + addVM+TimeOutPre(t,i);
       else
           for j = i-1 : i
               addVM = addVM + addVMArrays((j-1)*3+1:(j-1)*3+3);
           end
           vmArrays((i-1)*3+1:(i-1)*3+3) = addVM;
       end
    end
end

function [preVM] = pre(t,q)
    load('initPoints.mat','initPoints');
    flag = ((q-1)/q)*60;
    addVM = [0,0,0];
    if(t == 0)
        preVM(1:3) = 0;
        return;
    elseif(t > 0 && t <= flag)
        up = t/30;
        for i = 1 : up
            index = (t - i * 30) / 30 + 1;
            addVM = addVM + initPoints((index-1)*3+1:(index-1)*3+3)
        end
    else
        for i = 1 : q-1
            index = (t - i * 30) / 30 + 1;
            addVM = addVM + initPoints((index-1)*3+1:(index-1)*3+3)
        end
    end
    preVM(1:3) = addVM;
end

function [timeOutPre] = TimeOutPre(t,i)
    load('initPoints.mat','initPoints');
    timeOutPre = [0,0,0];
    if(i == 1)
        timeOutPre = [0,0,0];
    else
        for n = 2 : i
            index = ((t+(n-1)*30)-60)/30+1;
            flag = (60-t)/30+1;
            if(n > flag)
                timeOutPre = timeOutPre + initPoints((index-1)*3+1:(index-1)*3+3);
            end
        end
    end
end

function [qosTotal] = getQoS(workloads,vmArrays)
    global Model_svm_gaussian;
    temp = [];
    qosTotal = 0;
    for i = 1 : 6
        temp = [workloads(i,1:2),vmArrays((i-1)*3+1:(i-1)*3+3)];
        c = predict(Model_svm_gaussian,temp);
        qos = sigmf(c,[3.0 2.0]);
        qosTotal = qosTotal + qos;
    end
end

function [cost] = getCost(addVMArrays)
    small = 0;
    middle = 0;
    large = 0;
    [m,n] = size(addVMArrays);
    for i = 1 : n
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
