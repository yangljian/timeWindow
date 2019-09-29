function [result] = timeWindow()
    global Model_svm_gaussian;%引入Qos预测模型
    allPoint = [];
    workload = [];
    top3Result = [];
    allPoint = initVmAllocate();
end