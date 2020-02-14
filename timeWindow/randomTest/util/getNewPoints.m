function temp = getNewPoints(interval,temp)
    [m,n] = size(temp);
    for i = 1:n
%         if(mod(i,3) ==1)
%             temp(i) = 0;
%             continue;
%         end
        if(temp(i) >= interval && (8-temp(i)) >= interval)
            temp(i) = temp(i) + round(unifrnd(-interval,interval));
        elseif(temp(i) < interval)
            temp(i) = temp(i) + round(unifrnd(-temp(i),interval));
        elseif((8 - temp(i)) < interval)
            temp(i) = temp(i) + round(unifrnd(-interval,8-temp(i)));
        end
    end
end