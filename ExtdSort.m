function [ Bnum ] = ExtdSort(a,b)
n=length(a); %�趨����ά��
Bnum=b;
[~,index]=sort(a,'descend'); %a�Ӵ�С����,����������µ�����index
for i=1:n
Bnum(i)=b(index(i));
end
end

