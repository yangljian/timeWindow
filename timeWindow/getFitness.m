%function [fitness] = getFitness(workload,pre,vmArrays)
%����ʱ�䴰��3h�����س���30min���ʹ������÷����ظ���������
function [fitness] = getFitness(workloads,vmArrays)
    %fitness = 500 * getQos(workload,vmArrays) + getCost(pre,vmArrays)/8;
    fit = 0;
    sum = 0;
    calQoSVm = [];
    calCostVm = [];
    for i = 0 : 5
        if(i == 0)
           calQoSVm = vmArrays(1:3);
           calCostVm =  vmArrays(1:3);
        else
            temp = vmArrays((i*3)+1:(i*3)+3) - vmArrays(((i-1)*3)+1:((i-1)*3)+3);
            temp(temp < 0) = 0;
            calQoSVm = vmArrays(((i-1)*3)+1:((i-1)*3)+3) + temp;
            calCostVm = temp;
            vmArrays((i*3)+1:(i*3)+3) = temp;
        end
        fit = 320*getQos(workloads,calQoSVm) + 2.5*getCost(calCostVm);
        sum = sum + fit;
    end
    fitness = sum / 6;
end
