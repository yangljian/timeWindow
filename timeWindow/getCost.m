%function [result] = getCost(pre,vmArrays)
function [result] = getCost(vm)

    costL = getCostL(vm);%��������������������������ĵ�CostL
    
	%costD = getCostD(pre,vmArrays);%����ر���������ĵ�CostD
    
    %result = costL + costD; ʱ�䴰�ڲ���Ϊ1h�����Ժ��Թر������������
    result = costL;
end

%��������������������������ĵ�CostL
% function [result] = getCostL(vmArrays)
%     small = 0;
%     middle = 0;
%     large = 0;
%     for i = 1 : 18
%        if(mod(i,3) == 1)
%            small = small + vmArrays(i);
%        elseif(mod(i,3) == 2)
%            middle = middle + vmArrays(i);
%        else
%            large = large + vmArrays(i);
%        end
%     end
%     result = 17.61*small + 18.85*middle + 20.84*large;
% end

%����һ����������÷�����Ӧ��CostL
function [result] = getCostL(vm)
    
    result = 17.61*vm(1) + 18.85*vm(2) + 20.84*vm(3);
end

%����ر���������ĵ�CostD
function [result] = getCostD(pre,vmArrays)
    costD = 0;
    temp = reshapeArrays(vmArrays);%�ع����飬�������Ϊ��������Ҫ�Ľṹ
    for i = 1 : 5
       costD = costD + calAdjoinPointCostD(temp(i,:),temp(i + 1,:));%���������������costD
    end
    %if(any(pre) == 1)%����ʼ���ò�Ϊ0����������ʼ�����һ����costD�ļ���
    costD = costD + calAdjoinPointCostD(pre,temp(1,:));        
    %end
    result = costD;
end

%�ع����飬�������Ϊ��������Ҫ�Ľṹ
function [result] = reshapeArrays(vmArrays)
    temp = reshape(vmArrays,3,6);
    for i = 1 : 6
        result(i,:) = reshape(temp(:,i),1,3);
    end
end

%���������������costD
function [result] = calAdjoinPointCostD(pre,now)
    result = 17.61/4 * abs(pre(1)-now(1)) * heaviside(pre(1)-now(1))+...
    18.85/4 * abs(pre(2)-now(2)) * heaviside(pre(2)-now(2))+...
    20.84/4 * abs(pre(3)-now(3)) * heaviside(pre(3)-now(3));
end