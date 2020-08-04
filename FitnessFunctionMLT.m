function [ f ] = FitnessFunctionMLT( x )
load('TaSeInfo.mat'); %�������������Ϣ
load('MaResult.mat'); %���ط���ƥ����
TaNum = length(x)/2; %��������
DeNum = Ta(TaNum,1);  %��������������
tt = [1,3,4,7,8,10,12,13,16,18,19,22,25,28,30,31,34,37,38,39,40,42,43,46,49,50,52,55,56,59,60];  %��ʾÿ�������ߵĵ�һ�����������ID
SeNum = 50; %��������
alpha = 20; %�����ٶȳ���Ϊ20km/h
% beta = 0.5; %�����ɱ�����Ϊ0.5$/km
y=zeros(1,TaNum);  %y(i)Ϊ��i��������ѡ�����ID
z=zeros(1,TaNum);  %z(i)Ϊ��i����������ȼ�
So=zeros(SeNum,TaNum);  %SoΪ���Ƚ�����ж�Ӧһ��������Ϊ���������������ID
w=zeros(1,TaNum);  %�м����
TaTi=zeros(SeNum,TaNum);  %�������ʱ�����Ԫ�ص�ֵ��ʾ��Ӧ�����ִ�н���ʱ��
F=zeros(1,DeNum); %F���������洢ÿ�����������ߵ���������

%�����������ѡ��ķ��񣬰�����ID����So����
for i=1:TaNum
    y(i)=ceil((FindLocation(MaResult(i,:))-1)*x(i));   %y(i)Ϊ��i��������ѡ�����ID
    So(y(i),FindLocation(So(y(i),:)))=i; %���µ��Ƚ����
    z(i)=x(i+TaNum);   %z(i)Ϊ��i����������ȼ�
end

%���������������ȼ���Soÿ������������������������
for i=1:SeNum
    k=FindLocation(So(i,:))-1;
    if k>1
        for j=1:k   %�ѷ���Sj�����б�����������������ȼ���������w
            w(j)=z(So(i,j));
        end
        So(i,1:k)=ExtdSort(w(1:k),So(i,1:k)); %���ݶ�����w�����򣬶Է���Sj�����������ID���ж�Ӧ˳�������
    end
end

%������ݷ�����ȷ�������ÿ������Ľ���ʱ�䣬���¾���TaTi
%�����i������ĵ�һ�����񣨵�So(i,1)�������ڸ÷����ϵĽ���ʱ�䣬Ȼ����¾���TaTi�ĵ�i�е�1��
for i=1:SeNum
    if FindLocation(So(i,:))>1
        TaTi(i,1)= 0 + Ta(So(i,1),2)/Se(i,1) + Se(i,10)+Se(i,11)+Se(i,12) + sqrt((Ta(So(i,1),9)-Se(i,8))*(Ta(So(i,1),9)-Se(i,8))+(Ta(So(i,1),10)-Se(i,9))*(Ta(So(i,1),10)-Se(i,9)))*3.6/alpha;
    end
end

%��������i������ĵ�2,3,4,...�����񣨵�So(i,j)�������ڸ÷����ϵĽ���ʱ�䣬Ȼ����¾���TaTi�ĵ�i�е�j��
for i=1:SeNum
    if FindLocation(So(i,:))>2
        for j=2:FindLocation(So(i,:))-1
            TaTi(i,j)=TaTi(i,j-1)+Ta(So(i,j),2)/Se(i,1) + Se(i,10)+Se(i,11)+Se(i,12) + sqrt((Ta(So(i,j),9)-Se(i,8))^2+(Ta(So(i,j),10)-Se(i,9))^2)*3.6/alpha;
        end
    end
end

%������ÿ�����������ߵ������������󽻻���
for i=1:SeNum
    for j=1:FindLocation(So(i,:))-1
        F(Ta(So(i,j),1))=max(TaTi(i,j),F(Ta(So(i,j),1)));
    end
end

%�������Ż�Ŀ�꺯�����������û����ȼ��ļ�Ȩƽ���������񽻻�ʱ��
g=0;
for i=1:DeNum
    g=g+Ta(tt(i),11)*F(i);
end
f = g/DeNum/100000;
end