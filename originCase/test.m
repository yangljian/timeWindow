function [topResult] = test(clientNum,read,pre,vm)
% ���븺���������õ��ø��ص����
%   �˴���ʾ��ϸ˵��
    global Model_svm_gaussian;
    allPoint = [];
    allPoint(1) = clientNum / 400;
    allPoint(2) = read;
    allPoint(3:5) = vm;
    c = predict(Model_svm_gaussian, allPoint);
    allPoint(6)=fitnessY(c,pre,allPoint);
    topResult = allPoint;
end

