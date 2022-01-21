function T = targetFunction(NTr,NP)
T=zeros(NP,NP*NTr);
for i=1:NP
    T(i,NTr*(i-1)+1:NTr*(i-1)+NTr)=1;
end
end

