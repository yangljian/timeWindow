%����workload����ά���飬ÿ�а������������д�ʣ����������������
function [result] = getQos(workload,vm)
    result = calQos(workload,vm);
end

%���㵥���QoSֵ��ʹ�õĸ���������ʱ�䴰���ڵĸ��أ��������ȡ����ʱ�䴰�ڵ�ƽ��ֵ��Ϊ��һ�����QoSֵ��
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