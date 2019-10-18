% �������Ÿ���ָ���������fitnessֵ
function result = randomTest(interval,initPoint)
    disp(initPoint);
    betterPoints = [];
    allPoints = [];
    index = 1;
    p = 1;
    count = getCount(interval,initPoint);
    workload  = [8.75,0.25;6.25,0.35;11.25,0.25;7.5,0.25;5,0.35;10,0.15];
    pre = [0,2,5];
    %���㵥�����ų�ʼfitnessֵ
    fitness = getFitness(workload,[0,2,5],initPoint);
    while index <=6
%         flag1 = 0;
        %flag2 = 0;
        %��initPoint�����е��ƶ���2
        temp = getNewPoints(interval,initPoint);
        %allPoints(p,:) = temp;
        newFitness = getFitness(workload,pre,temp);
        if(newFitness < fitness)
            fitness = newFitness;
            betterPoints(index,1:18) = temp;
            betterPoints(index,19) = fitness;
            index = index + 1;
        end
         p = p + 1;
%          for j = 1 : p
%                %�ж��Ƿ������д�����ͬ�ķ���
%                if(isequal(allPoints(j,:),temp))
%                    flag1 = 1;
%                end
%          end
%             newFitness = getFitness(workload,pre,temp);
%             if(newFitness < fitness)
%                 fitness = newFitness;
%                 betterPoints(index,1:18) = temp;
%                 betterPoints(index,19) = newFitness;
%                 index = index + 1;
%             end
%            if(~flag2)%����÷������µģ��������fitnessֵ
%                newFitness = getFitness(workload,pre,temp);
%                if(newFitness < fitness)%��fitnessֵС�ڵ������ŷ����ķ�������������
%                    fitness = newFitness;
%                    betterPoints(index,1:18) = temp;
%                    betterPoints(index,19) = newFitness;
%                    index = index + 1;
%                end
%            end
%         end
%      end
    end
    result = betterPoints;
end

function count = getCount(interval,initPoint)
    count = 1;
    for i = 1:18
        if(initPoint(i) >= interval && (8-initPoint(i)) >= interval)
            count = count * (interval * 2);
        elseif(initPoint(i) < interval)
            count = count * (interval + initPoint(i));
        elseif((8 - initPoint(i)) < interval)
            count = count * (interval + (8 - initPoint(i)));
        end
    end
end

function temp = getNewPoints(interval,temp)
    for i = 1:18
        if(temp(i) >= interval && (8-temp(i)) >= interval)
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        elseif(temp(i) < interval)
            temp(i) = temp(i) + round(unifrnd(-temp(i),interval));
        elseif((8 - temp(i)) < interval)
            temp(i) = temp(i) + round(unifrnd(-interval,8 - temp(i)));
        end
    end
end