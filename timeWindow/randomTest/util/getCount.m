function count = getCount(interval,vmArrays)
    count = 1;
    [m,n] = size(vmArrays);
    for i = 1:n
%         if(mod(i,3) == 1)
%             continue;
%         end
        if(vmArrays(i) >= interval && (8-vmArrays(i)) >= interval)
            count = count * (interval * 2);
        elseif(vmArrays(i) < interval)
            count = count * (interval + vmArrays(i));
        elseif((8 - vmArrays(i)) < interval)
            count = count * (interval + (8 - vmArrays(i)));
        end
    end
end