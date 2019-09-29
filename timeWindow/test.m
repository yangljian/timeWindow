function [result] = combinationVms()
    result = [];
    index = 1;
    workload = [6.25,0.35;7.5,0.25;8.75,0.25;9.75,0.15;10,0.15;10.5,0.35];
    initVm = [0,0,0];
    arrays = initArrays();
    fitness = 0;
    temp = [];
    for i = 1 : 728
        for j = 1 : 728
            for k = 1 : 728
                for m = 1 : 728
                    for n = 1 : 728
                        for p = 1 : 728
                            result(index,1:18) = [arrays(i,:,1),arrays(j,:,2),arrays(k,:,3),arrays(m,:,4),arrays(n,:,5),arrays(p,:,6)];
                            result(index,19) = getFitness(workload,initVm,result(index,1:18));
                            flag = size(temp);
                            if(fitness < result(index,19) && fitness  ~= 0)
                                index = index + 1;
                                continue;
                            else
                                fitness = result(index,19);
                                temp(flag(1) + 1,:) = result(index,:);
                                save temp;
                                index = index + 1;
                            end
                        end
                    end
                end
            end
        end
    end
end

function [result] = initArrays()
    index = 0;
    allPoint = [];
    for small = 0:8
        for mid = 0:8
            for large = 0:8
                if small == 0 && mid == 0 && large == 0
                    continue;
                else
                    index = index + 1;
                    allPoint(index,1) = small;
                    allPoint(index,2) = mid;
                    allPoint(index,3) = large;
                end
            end
        end
    end
    for i = 1 : 6
       result(:,:,i) = allPoint;
    end
end