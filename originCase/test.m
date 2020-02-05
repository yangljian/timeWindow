function [topResult] = test(clientNum,read,pre,vm)
% 输入负载数量，得到该负载的情况
%   此处显示详细说明
    global Model_svm_gaussian;
    allPoint = [];
    allPoint(1) = clientNum / 400;
    allPoint(2) = read;
    allPoint(3:5) = vm;
    c = predict(Model_svm_gaussian, allPoint);
    allPoint(6)=fitnessY(c,pre,allPoint);
    topResult = allPoint;
end

