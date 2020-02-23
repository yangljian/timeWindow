function [result] = gaTest(t)
    %������Ҫʹ�õ��ĺ�����
    addpath('E:\ʱ�䴰��ʵ��\timeWindow\randomTest\util');
    %�����������t����ȡ��ǰ�ĸ���
    workload = getWindowsData(t,1);
    global allPlan;
    disp(workload);
    q = 2;
    load('E:\ʱ�䴰��ʵ��\timeWindow\datas\gaAddPlan.mat','gaAddPlan');
    %��ȡ��ʼ���������
    preVM = getPre(q,gaAddPlan);
    %��ʼ�����ܵ����ݼ���������ģ�ͼ���
    allPlan = getAllPlan(preVM,workload);
    resultAddVM = [0,0,0];
    resultPlan = [];
    %calculate init fitness
    fitness = calFitness([workload,preVM]);
    resultPlan = fitness;
    t1 = clock;
    t2 = clock;
    while etime(t2,t1) <= 60 && ~isempty(allPlan)
        plan = getNewPlan();
        temp = calFitness(plan);
        if(temp(end) < resultPlan(end))
            resultPlan = temp;
            resultAddVM = temp(3:5) - preVM;
        end
        t2 = clock;
    end
    saveData(resultPlan,resultAddVM);
end

function [preVM] = getPre(q,gaAddPlan)
    preVM = [0,0,0];
    [m,n] = size(gaAddPlan);
    if(m == 0)
       return;
    elseif(m > 0)
       for i = m : -1 : m-q+2
           preVM = preVM + gaAddPlan(i,1:3);
       end
    end
end

function [allVMPlan] = getAllPlan(preVM,workload)
    small = preVM(1);
    middle = preVM(2);
    large = preVM(3);
    index = 0;
    for i = large : 8
        for j = middle : 8
            for k = small : 8
                index = index + 1;
                curr = preVM + [i,j,k];
                allVMPlan(index,1:5) = [workload,curr];
            end
        end
    end
                
end

function [addVM] = getNewPlan()
    global allPlan;
    [m,n] = size(allPlan);
    index = round(unifrnd(1,m));
    addVM = allPlan(index,:);
    allPlan(index,:) = [];
end

function [resultPlan] = calFitness(plan)
    global Model_svm_gaussian;
    c = predict(Model_svm_gaussian,plan);
    qos = sigmf(c,[-3.0 2.0]);
    cost = 17.61*plan(3) + 18.85*plan(4) + 20.84*plan(5);
    fit = 260/qos + cost/4;
    resultPlan = [plan,qos,cost,fit];
end