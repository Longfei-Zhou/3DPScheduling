load('TaSeInfo.mat'); %�������񡢷�������
MaRes = zeros(Z,50); %�������ƥ��������

for i=1:Z  %���ڵ�i������
    for j=1:50   %���ڵ�j������
        if min(Ta(i,3),Ta(i,4))<=min(Se(j,2),Se(j,3)) && max(Ta(i,3),Ta(i,4))<=max(Se(j,2),Se(j,3)) && Ta(i,5)<=Se(j,4) && Ta(i,6)==Se(j,5) && Ta(i,7)>=Se(j,6)   %�������ĳߴ硢���ϡ����Ⱥͼ۸����������Ҫ��
            k = FindLocation(MaRes(i,:));
            MaRes(i,k) = j;  %���÷����ID�������ƥ�������
        end
    end
end