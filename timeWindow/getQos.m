%����workload����ά���飬ÿ�а������������д�ʣ����������������
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