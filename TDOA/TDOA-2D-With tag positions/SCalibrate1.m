function ErrFun= SCalibrate1(Sc,Sm,td,v,n,p)
%known tag positions and the TDOA measurements
p_known=[3,2;
         2,6
         3,5
         4,4];
td_known=[-4.64816241512004e-09,1.44151844011225e-08,8.89558078225641e-09,3.94906098164267e-09;
          -6.83767658009464e-09,4.41518440112253e-09,5.69282089742547e-09,6.83767658009464e-09;
          -2.88861559845197e-09,-4.95231451856632e-09,-1.90724114195849e-09,2.18951416497460e-09];

Sc=[Sc;p_known];
td=[td,td_known];
p=p+4;
for m=1:p
    r0=sqrt((Sm(1,1)-Sc(n+m,1))^2+(Sm(1,2)-Sc(n+m,2))^2);
end
for j=1:n
    for k=1:p
        %r0=sqrt((Sm(1,1)-Sc(n+m,1))^2+(Sm(1,2)-Sc(n+m,2))^2);
        r(j,k)=sqrt((Sc(j,1)-Sc(n+k,1))^2+(Sc(j,2)-Sc(n+k,2))^2);
    end
    ErrFun(j,:)=r0-r(j,:)-v*td(j,:);
end

end
