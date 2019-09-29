function [result] = initVm()
    arrays = [];
    result = [];
    for i = 1 : 6
        arrays(:,:,i) = initSingle();
    end
    result = arrays;
end


function [result] = initSingle()
    result = [];
    index = 0;
    for i = 0 : 8
        for j = 0 : 8
            for k = 0 : 8
                if(i==0 && j==0 && k==0)
                    continue;
                else
                    index = index + 1;
                    result(index,1) = i;
                    result(index,2) = j;
                    result(index,3) = k;
                end
            end
        end
    end
end