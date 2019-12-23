%输入workload（二维数组，每行包含负载量与读写率）与六中虚拟机配置
function [result] = getQos(workload,vm)
    result = calQos(workload,vm);
end

%计算单点的QoS值（使用的负载是整个时间窗口内的负载，所以最后取整个时间窗口的平均值作为第一个点的QoS值）
function [result] = calQos(workload,vm)
    global Model_svm_gaussian;
    temp = [];
    qosTotal = 0;
    for i = 1 : 6
        temp = [workload(i,1:2),vm];
        c = predict(Model_svm_gaussian,temp);
        qos = sigmf(c,[3.0 2.0]);
        qosTotal = qosTotal + qos;
    end
    result = qosTotal/6;
end