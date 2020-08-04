%设置参数
M = 71;  % 需求者数量
d = ceil(3*rand(M,1)); % 每个需求者的任务数量
Z = sum(d); % 任务总数
N = 50; % 服务总数

%生成任务数据,矩阵Ta的每行代表一个任务,每列分别表示任务的{需求者、代码长度、模型长、宽、高、材料、精度、价格、横坐标、纵坐标}.
Ta = zeros(Z,10); %声明任务矩阵
k=1;
for i=1:M
    for j=k:k+d(i)-1
        Ta(j,1)=i; %任务矩阵第1列表示该任务所属的 Service demander ID
    end
    k=k+d(i);
end
Ta(:,2) = 100+100*rand(Z,1); %任务矩阵第2列表示任务G-code的轨迹距离，范围：100-200m
Ta(:,3) = 0.2+0.6*rand(Z,1); %任务矩阵第3列表示任务3D模型的长度，范围：0.2-0.8m
for i=1:Z
    Ta(i,4) = Ta(i,3)*(0.9+0.2*rand(1,1)); %3D模型的宽度为长度的（0.9~1.1）倍
end
Ta(:,5) = 0.2+0.6*rand(Z,1); %任务矩阵第5列表示任务3D模型的高度，范围：0.2-0.8m
Ta(:,6) = ceil(5*rand(Z,1)); %第6列为任务的打印材料类型需求，范围：{1,2,3,4,5}分别代表{ABS,PLA,Nylon,Resin,Acrylic}
Ta(:,7) = 0.01*ceil(6*rand(Z,1)); %第7列为任务的打印精度需求，范围：{0.01mm,0.02mm,0.03mm,0.04mm,0.05mm,0.06mm}
Ta(:,8) = 5+10*rand(Z,1);  %第8列为任务的价格上限，包括打印成本和物流成本,范围：5-15$
Ta(:,9) = 50000*rand(Z,1);  %第9列为任务所属需求者的横坐标,范围：0-50000m
Ta(:,10) = 50000*rand(Z,1);  %第10列为任务所属需求者的纵坐标,范围：0-50000m

%生成服务数据,矩阵Se的每行代表一个服务，每列分别表示服务的{喷头速度、成型尺寸长、宽、高、材料、精度、单位成本、横坐标、纵坐标、预热时间、冷却时间、拆卸时间}.
Se = zeros(N,12);
Se(:,1) = 0.015+0.01*rand(N,1); %喷头速度范围为：0.015-0.025m/s
Se(:,2) = 0.4+0.6*rand(N,1); %成型尺寸长度范围：0.4-1m
for i=1:N
    Se(i,3) = Se(i,2)*(0.9+0.2*rand(1,1)); %成型尺寸的宽度为长度的（0.9~1.1）倍
end
Se(:,4) = 0.4+0.6*rand(N,1); %成型尺寸高度范围：0.4-1m
Se(:,5) = ceil(5*rand(N,1)); %材料范围：{1,2,3,4,5}分别代表{ABS,PLA,Nylon,Resin,Acrylic}
Se(:,6) = 0.01*ceil(6*rand(N,1)); %精度范围：{0.01mm,0.02mm,0.03mm,0.04mm,0.05mm,0.06mm}
Se(:,7) = 1+4*rand(N,1); %单位时间标准精度的打印成本，范围：1-5$
Se(:,8) = 50000*rand(N,1); %服务横坐标,范围：0-50000m
Se(:,9) = 50000*rand(N,1); %服务纵坐标,范围：0-50000m
Se(:,10) = 600+600*rand(N,1);  %服务的预热时间，范围600-1200秒（即10-20分钟）
Se(:,11) = 600+600*rand(N,1);  %服务的冷却时间，范围600-1200秒（即10-20分钟）
Se(:,12) = 600+600*rand(N,1);  %服务的拆卸时间，范围600-1200秒（即10-20分钟）