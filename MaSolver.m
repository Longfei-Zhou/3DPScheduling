load('TaSeInfo.mat'); %加载任务、服务数据
MaRes = zeros(Z,50); %定义服务匹配结果矩阵

for i=1:Z  %对于第i个任务
    for j=1:50   %对于第j个服务
        if min(Ta(i,3),Ta(i,4))<=min(Se(j,2),Se(j,3)) && max(Ta(i,3),Ta(i,4))<=max(Se(j,2),Se(j,3)) && Ta(i,5)<=Se(j,4) && Ta(i,6)==Se(j,5) && Ta(i,7)>=Se(j,6)   %如果服务的尺寸、材料、精度和价格都满足任务的要求。
            k = FindLocation(MaRes(i,:));
            MaRes(i,k) = j;  %将该服务的ID存入服务匹配矩阵中
        end
    end
end