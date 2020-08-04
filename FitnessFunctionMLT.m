function [ f ] = FitnessFunctionMLT( x )
load('TaSeInfo.mat'); %加载任务服务信息
load('MaResult.mat'); %加载服务匹配结果
TaNum = length(x)/2; %任务数量
DeNum = Ta(TaNum,1);  %服务需求者数量
tt = [1,3,4,7,8,10,12,13,16,18,19,22,25,28,30,31,34,37,38,39,40,42,43,46,49,50,52,55,56,59,60];  %表示每个需求者的第一个任务的任务ID
SeNum = 50; %服务数量
alpha = 20; %物流速度常数为20km/h
% beta = 0.5; %物流成本常数为0.5$/km
y=zeros(1,TaNum);  %y(i)为第i个任务所选服务的ID
z=zeros(1,TaNum);  %z(i)为第i个任务的优先级
So=zeros(SeNum,TaNum);  %So为调度解矩阵，行对应一个服务，列为服务所分配的任务ID
w=zeros(1,TaNum);  %中间变量
TaTi=zeros(SeNum,TaNum);  %任务结束时间矩阵，元素的值表示对应任务的执行结束时间
F=zeros(1,DeNum); %F矩阵用来存储每个服务需求者的最晚交货期

%下面根据任务选择的服务，把任务ID存入So矩阵
for i=1:TaNum
    y(i)=ceil((FindLocation(MaResult(i,:))-1)*x(i));   %y(i)为第i个任务所选服务的ID
    So(y(i),FindLocation(So(y(i),:)))=i; %更新调度解矩阵
    z(i)=x(i+TaNum);   %z(i)为第i个任务的优先级
end

%下面根据任务的优先级对So每个服务所分配的任务进行排序
for i=1:SeNum
    k=FindLocation(So(i,:))-1;
    if k>1
        for j=1:k   %把服务Sj的所有被分配任务的任务优先级存入向量w
            w(j)=z(So(i,j));
        end
        So(i,1:k)=ExtdSort(w(1:k),So(i,1:k)); %根据对向量w的排序，对服务Sj所分配的任务ID进行对应顺序的排序
    end
end

%下面根据服务调度方案计算每个任务的结束时间，更新矩阵TaTi
%计算第i个服务的第一个任务（第So(i,1)个任务）在该服务上的交付时间，然后更新矩阵TaTi的第i行第1列
for i=1:SeNum
    if FindLocation(So(i,:))>1
        TaTi(i,1)= 0 + Ta(So(i,1),2)/Se(i,1) + Se(i,10)+Se(i,11)+Se(i,12) + sqrt((Ta(So(i,1),9)-Se(i,8))*(Ta(So(i,1),9)-Se(i,8))+(Ta(So(i,1),10)-Se(i,9))*(Ta(So(i,1),10)-Se(i,9)))*3.6/alpha;
    end
end

%下面计算第i个服务的第2,3,4,...个任务（第So(i,j)个任务）在该服务上的交付时间，然后更新矩阵TaTi的第i行第j列
for i=1:SeNum
    if FindLocation(So(i,:))>2
        for j=2:FindLocation(So(i,:))-1
            TaTi(i,j)=TaTi(i,j-1)+Ta(So(i,j),2)/Se(i,1) + Se(i,10)+Se(i,11)+Se(i,12) + sqrt((Ta(So(i,j),9)-Se(i,8))^2+(Ta(So(i,j),10)-Se(i,9))^2)*3.6/alpha;
        end
    end
end

%下面求每个服务需求者的所有任务的最大交货期
for i=1:SeNum
    for j=1:FindLocation(So(i,:))-1
        F(Ta(So(i,j),1))=max(TaTi(i,j),F(Ta(So(i,j),1)));
    end
end

%下面求优化目标函数，即基于用户优先级的加权平均最晚任务交货时间
g=0;
for i=1:DeNum
    g=g+Ta(tt(i),11)*F(i);
end
f = g/DeNum/100000;
end