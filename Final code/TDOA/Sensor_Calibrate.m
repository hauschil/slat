%% Function formulating the objective function for the optimizer
function ErrFun= Sensor_Calibrate(X,Sm,td,v,ns,xt_known,yt_known,td_known)

%Concatinating the known and unkown emitter positions
for k=ns+1:size(X)
    xt_known=horzcat(xt_known,X(k,1));
    yt_known=horzcat(yt_known,X(k,2));
end

%Concatinating the TDOA measurements of known and unknown emitter positions
td_known=horzcat(td_known,td);

r0=sqrt((xt_known-Sm(1,1)).^2+(yt_known-Sm(1,2)).^2);
for p=1:ns
    r(p,:)=sqrt((xt_known-X(p,1)).^2+(yt_known-X(p,2)).^2);
    ErrFun(p,:)=r0-r(p,:)-td_known(p,:)*v;
end

end