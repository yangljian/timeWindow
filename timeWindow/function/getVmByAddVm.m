%{
function [vmArrays,addVMArrays] = getVmByAddVm(addVMArrays,t,addPlan)
    flag = 30;%  δt，间隔时间
    q = 60/flag;
    global length;%窗口长度
    preVM = getPre(t,q,addPlan);%时刻t的初始虚拟机配置
    for i = 1 : length
       addVM = [0,0,0];
       if(i <= q)
           for j = 1 : i
               addVM = addVM + addVMArrays((j-1)*3+1:(j-1)*3+3);
           end
           vmArrays((i-1)*3+1:(i-1)*3+3) = preVM + addVM - timeOutPre(t,i,addPlan);
       else
           for j = i-1 : i
               addVM = addVM + addVMArrays((j-1)*3+1:(j-1)*3+3);
           end
           vmArrays((i-1)*3+1:(i-1)*3+3) = addVM;
       end
    end
    result = find(vmArrays > 8);
    [m,n] = size(result);
    for i = 1 : n
        addVMArrays((result(i))) = addVMArrays((result(i))) - vmArrays(result(i))+8;
    end
end
%}

function [vmArrays,addVMArrays] = getVmByAddVm(addVMArrays,t,addPlan)
    flag = 30;%  δt，间隔时间
    q = 60/flag;
    index = t/flag;
    global length;%窗口长度
    %先从后边算起
    for i = 3 : -1 : q
        addVM = [0,0,0];
        for j = 1 : q
            addVM = addVM + addVMArrays((i-j)*3+1:(i-j)*3+3);
        end
        vmArrays((i-1)*3+1:(i-1)*3+3) = addVM;
    end
    
    [m,n] = size(addPlan); 
    
    for i = q-1 : -1 : 1
        addVM = [0,0,0];
        pre = [0,0,0];
        for j = i : 1
            addVM = addVM + addVMArrays((i-j)*3+1:(i-j)*3+3);
        end
        if(m >= q-1)
            temp = q-i;
            for k = m : m-temp+1
                pre = pre + addPlan(k,1:3);
            end
            addVM = addVM + pre;
        elseif(m > 0 && m < q-1)
            for k = m : -1 : 1
                pre = pre + addPlan(k,1:3);
            end
            addVM = addVM + pre;
        end
        vmArrays((i-1)*3+1:(i-1)*3+3) = addVM;
    end
    result = find(vmArrays > 8);
    [m,n] = size(result);
    for i = 1 : n
        addVMArrays((result(i))) = addVMArrays((result(i))) - vmArrays(result(i))+8;
    end
end