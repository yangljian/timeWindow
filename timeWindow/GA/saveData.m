function saveDatas(resultPlan,resultAddVM)
    load(['E:\时间窗口实验\timeWindow\datas\gaPlan.mat'],'gaPlan');
    load(['E:\时间窗口实验\timeWindow\datas\gaAddPlan.mat'],'gaAddPlan');
    [m,n] = size(gaAddPlan);
    [x,y] = size(gaPlan);
    gaPlan(x+1,1:8) = resultPlan;
    gaAddPlan(m+1,1:3) = resultAddVM;
    save('E:\时间窗口实验\timeWindow\datas\gaAddPlan.mat','gaAddPlan');
    save('E:\时间窗口实验\timeWindow\datas\gaPlan.mat','gaPlan');
end

