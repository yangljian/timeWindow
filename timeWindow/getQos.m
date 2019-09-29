%输入workload（二维数组，每行包含负载量与读写率）与六中虚拟机配置
function [result] = getQos(workload,vmArrays)
    result = calQos(workload,vmArrays);
end

function [result] = calQos(workload,vmArrays)
    global Model_svm_gaussian;
    temp = [];
    qosTotal = 0;
    for i = 0 : 5
        for j = 1 : 6
            temp = [workload(j,1:2),vmArrays(3*i+1:3*i+3)];
            c = predict(Model_svm_gaussian,temp);
            qos = sigmf(c,[3.0 2.0]);
            qosTotal = qosTotal + qos;
        end
    end
    result = qosTotal/36;
end