function [topResult] = top5Percent(clientNum, read)
% 输入负载数量，得到该负载的情况
%   此处显示详细说明
    global Model_svm_gaussian;
    allPoint = [];
    index = 0;
    for small = 0:8
        for mid = 0:8
            for large = 0:8
                if small == 0 && mid == 0 && large == 0
                    continue;
                else
                    
                    index = index + 1;
                    allPoint(index,1) = clientNum / 400;
                    allPoint(index,2) = read;
                    allPoint(index,3) = small;
                    allPoint(index,4) = mid;
                    allPoint(index,5) = large;
                  
                end
            end
        end
    end
    allPoint(1:index,6) = predict(Model_svm_gaussian, allPoint);
    for i = 1 : index
        allPoint(i,7) =  fitnessY(allPoint(i,6), [0,0,0], allPoint(i,3:5));
    end
    %topResult = allPoint;
    for i = 1 : index
        for j = 1 : index - i
            if allPoint(j,7) > allPoint(j+1,7)
                temp = allPoint(j+1,1:7);
                allPoint(j+1,1:7) = allPoint(j,1:7);
                allPoint(j,1:7) = temp;
            end
        end
    end
    topResult = allPoint(1:index*0.05,1:7);
end

