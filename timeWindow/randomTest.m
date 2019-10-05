%�������Ÿ���ָ���������fitnessֵ
function result = randomTest(interval,initPoint)
    disp(initPoint);
    points = [];
    index = 1;
    workload  = [6.25,0.35;7.5,0.25;8.75,0.25;9.75,0.15;10,0.15;10.5,0.35];
    pre = [0,2,5];
    fitness = getFitness(workload,pre,initPoint);
    while index <= 100
        temp = initPoint;
        for i = 1:18
            %��initPoint�����е��ƶ���2
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        end
        %�ж��Ƿ��и�ֵ�Լ��Ƿ񳬳���������̨��
        flag=~isempty(find(temp<0)) || ~isempty(find(temp>8));
        if(flag)
            continue;
        elseif(index == 1)%��ʼ��ֵ
            points(index,1:18) = temp;
            points(index,19) = getFitness(workload,pre,temp);
            index = index + 1;
        else
           for j = 1:index-1
               %�ж��Ƿ������д�����ͬ�ķ���
               if(isequal(points(j,:),temp))
                   flag = 1;
               end
           end
           if(~flag)%����÷������µģ��������fitnessֵ
               newFitness = getFitness(workload,pre,temp);
               if(newFitness < fitness)%��fitnessֵС�ڵ������ŷ����ķ�������������
                   fitness = newFitness;
                   points(index,1:18) = temp;
                   points(index,19) = newFitness;
                   index = index + 1;
               end
           end
        end
    end
end

function randomPoint = getOneRandom(interval,point)
    small = point(1);
    middle = point(2);
    large  = point(3);
    
end