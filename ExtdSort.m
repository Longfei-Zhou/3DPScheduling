function [ Bnum ] = ExtdSort(a,b)
n=length(a); %设定向量维数
Bnum=b;
[~,index]=sort(a,'descend'); %a从大到小排列,返回排序后新的索引index
for i=1:n
Bnum(i)=b(index(i));
end
end

