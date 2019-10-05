function f = fitnessY(c,pre,now)
%补上时间、资源数、起始资源数
qos= sigmf(c,[3.0 2.0]);
 

if  qos>=0.0 && qos<=0.32
    b = 1;
else
    b = 100;
end

%计算cost, 
cost=( 17.61*now(1) + 18.85*now(2) + 20.84*now(3))+...
    3*(17.61/4 * abs(pre(1)-now(1)) * heaviside(pre(1)-now(1))+...
    18.85/4 * abs(pre(2)-now(2)) * heaviside(pre(2)-now(2))+...
    20.84/4 * abs(pre(3)-now(3)) * heaviside(pre(3)-now(3)));
%之前：110*c
f=(1)*320*qos +...
   (1)*cost;
%fprintf('The fitness is %8.5f， the qos is %8.5f, the cost is %8.5f，the b is %d\n', f,qos,cost,b);
end

