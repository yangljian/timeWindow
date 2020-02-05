function [addVM] = getAddPlan(windowVMPlan,length,t)
    load('initPoints.mat','initPoints');
    index = t/30 + 1;
    for i = 1:length
        if(t == 0 && i == 1)
            addVM((i-1)*3+1:(i-1)*3+3) = windowVMPlan(1:3);
        elseif(t > 0 && i == 1)
            addVM((i-1)*3+1:(i-1)*3+3) = windowVMPlan(1:3)-initPoints((index-1)*3-2:(index-1)*3);
        else
            addVM((i-1)*3+1:(i-1)*3+3) = windowVMPlan((i-1)*3+1:(i-1)*3+3)-addVM((i-2)*3+1:(i-2)*3+3);
        end
    end
    addVM(addVM<0) = 0;
end