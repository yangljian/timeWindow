%function [result] = getCost(pre,vmArrays)
function [result] = getCost(vm)

    costL = getCostL(vm);%计算六种配置租赁虚拟机所消耗的CostL
    
	%costD = getCostD(pre,vmArrays);%计算关闭虚拟机消耗的CostD
    
    %result = costL + costD; 时间窗口步长为1h，可以忽略关闭虚拟机的消耗
    result = costL;
end

%计算六种配置租赁虚拟机所消耗的CostL
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

%计算一个虚拟机配置方案对应的CostL
function [result] = getCostL(vm)
    
    result = 17.61*vm(1) + 18.85*vm(2) + 20.84*vm(3);
end

%计算关闭虚拟机消耗的CostD
function [result] = getCostD(pre,vmArrays)
    costD = 0;
    temp = reshapeArrays(vmArrays);%重构数组，将数组变为计算所需要的结构
    for i = 1 : 5
       costD = costD + calAdjoinPointCostD(temp(i,:),temp(i + 1,:));%计算相邻两个点的costD
    end
    %if(any(pre) == 1)%若初始配置不为0，则需加入初始点与第一个点costD的计算
    costD = costD + calAdjoinPointCostD(pre,temp(1,:));        
    %end
    result = costD;
end

%重构数组，将数组变为计算所需要的结构
function [result] = reshapeArrays(vmArrays)
    temp = reshape(vmArrays,3,6);
    for i = 1 : 6
        result(i,:) = reshape(temp(:,i),1,3);
    end
end

%计算相邻两个点的costD
function [result] = calAdjoinPointCostD(pre,now)
    result = 17.61/4 * abs(pre(1)-now(1)) * heaviside(pre(1)-now(1))+...
    18.85/4 * abs(pre(2)-now(2)) * heaviside(pre(2)-now(2))+...
    20.84/4 * abs(pre(3)-now(3)) * heaviside(pre(3)-now(3));
end