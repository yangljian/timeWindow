function saveDatas(bestAddPoints,prefix,t)
    global length;
    if("psoGa" == prefix)
        load(['E:\时间窗口实验\timeWindow\datas\psoGaPlan.mat'],'psoGaPlan');
        load(['E:\时间窗口实验\timeWindow\datas\psoGaAddPlan.mat'],'psoGaAddPlan');
        [m,n] = size(psoGaAddPlan);
        [x,y] = size(psoGaPlan);
        psoGaAddPlan(m+1,:) = bestAddPoints(1:length*3);
        save(['E:\时间窗口实验\timeWindow\datas\psoGaAddPlan.mat'],'psoGaAddPlan');
        result = getVmByAddVm(bestAddPoints,t,psoGaAddPlan);
        psoGaPlan(x+1,1:length*3) = result(1:length*3);
        psoGaPlan(x+1,length*3+1) = bestAddPoints(1,length*3+1);
        save(['E:\时间窗口实验\timeWindow\datas\psoGaPlan.mat'],'psoGaPlan');
    else
        load(['E:\时间窗口实验\timeWindow\datas\randomPlan.mat'],'randomPlan');
        load(['E:\时间窗口实验\timeWindow\datas\randomAddPlan.mat'],'randomAddPlan');
        [m,n] = size(randomAddPlan);
        [x,y] = size(randomPlan);
        randomAddPlan(m+1,:) = bestAddPoints(1:length*3);
        save(['E:\时间窗口实验\timeWindow\datas\randomAddPlan.mat'],'randomAddPlan');
        result = getVmByAddVm(bestAddPoints,t,randomAddPlan);
        randomPlan(x+1,1:length*3) = result(1:length*3);
        randomPlan(x+1,length*3+1) = bestAddPoints(1,length*3+1);
        save(['E:\时间窗口实验\timeWindow\datas\randomPlan.mat'],'randomPlan');
    end
    
    
end

