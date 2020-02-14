function [timeOutPre] = TimeOutPre(t,i,addPlan)
    timeOutPre = [0,0,0];
    q = 60/30;
    length = 3;
    if(i > 1 && i <= q && t > 0)
        for n = 2 : i
            index = ((t+(n-1)*30)-60)/30+1;
            flag = (60-t)/30+1;
            if(n >= flag)
                timeOutPre = timeOutPre + addPlan(index,1:3);
            end
        end
    else
        timeOutPre = [0,0,0];
    end
end