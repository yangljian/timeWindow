function saveDatas(resultPlan,resultAddVM)
    load(['E:\ʱ�䴰��ʵ��\timeWindow\datas\gaPlan.mat'],'gaPlan');
    load(['E:\ʱ�䴰��ʵ��\timeWindow\datas\gaAddPlan.mat'],'gaAddPlan');
    [m,n] = size(gaAddPlan);
    [x,y] = size(gaPlan);
    gaPlan(x+1,1:8) = resultPlan;
    gaAddPlan(m+1,1:3) = resultAddVM;
    save('E:\ʱ�䴰��ʵ��\timeWindow\datas\gaAddPlan.mat','gaAddPlan');
    save('E:\ʱ�䴰��ʵ��\timeWindow\datas\gaPlan.mat','gaPlan');
end

