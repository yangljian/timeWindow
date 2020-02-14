function [preVM] = getPre(t,q,addPlan)
    flag = ((q-1)/q)*60;
    addVM = [0,0,0];
    if(t == 0)
        preVM(1:3) = 0;
        return;
    elseif(t > 0 && t <= flag)
        up = t/30;
        for i = 1 : up
            index = (t - i * 30) / 30 + 1;
            addVM = addVM + addPlan(index,1:3);
        end
    else
        for i = 1 : q-1
            index = (t - i * 30) / 30 + 1;
            addVM = addVM + addPlan(index,1:3);
        end
    end
    preVM(1:3) = addVM;
end