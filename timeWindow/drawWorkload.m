x=0:30:540;
for i = 1 : length(x)-1
%     if(i <= 13)    
        y(i) = workloads(i,1)*400;        
%     else
%         y(i) = workloads(13,1)*400;
%     end
    plot((i-1)*30:30:i*30,[y(i) y(i)],'black','LineWidth',2);
    hold on;
end
axis([0 540 0 7500]);
set(gca,'xtick',(0:30:540));
% 创建 ylabel
ylabel('Number of Clients');

% 创建 xlabel
xlabel('Time Interval');