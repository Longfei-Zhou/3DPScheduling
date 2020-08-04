function z = FindLocation( x )
%FINDLOCATION Summary of this function goes here
%   Detailed explanation goes here
n=length(x);
    for j=1:n
        k=n+1-j;
        if (x(k)~=0)
            z=k+1;
            break
        else
            z=1;
        end
    end
end

