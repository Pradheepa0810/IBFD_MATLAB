W = 107800:100:108500;
L = 4.2;
l1= 2.7:0.1:3.4;
l2= L-l1;
h= 1.45:0.05:1.80;
fr=0.006;
mue_peak=0.6;
Kbf=l2+((mue_peak+fr).*h);
Kbr=l1-((mue_peak+fr).*h);

IBFD_decimal=Kbf./Kbr;
rear_wheel_brake_force_percent=(100)./(IBFD_decimal+1);
front_wheel_brake_force_percent=100-rear_wheel_brake_force_percent;
Kbf=front_wheel_brake_force_percent./100;
Kbr=rear_wheel_brake_force_percent./100;

deceleration_limit_for_front_wheel_lock=((mue_peak.*l2)+(fr*L.*Kbf))./((L.*Kbf)-(mue_peak.*h));
deceleration_limit_for_rear_wheel_lock=((mue_peak.*l1)+(fr*L.*(1-Kbf)))./((L.*(1-Kbf))+(mue_peak.*h));
front_wheel_lock=zeros(1,8);
rear_wheel_lock=zeros(1,8);
Brake_efficiency=zeros(1,8);

for i=1:8
if (deceleration_limit_for_front_wheel_lock(i) < deceleration_limit_for_rear_wheel_lock(i))
    front_wheel_lock(i)=1;
    rear_wheel_lock(i)=0;
elseif deceleration_limit_for_rear_wheel_lock(i) < deceleration_limit_for_front_wheel_lock(i)
    front_wheel_lock(i)=0;
    rear_wheel_lock(i)=1;  
end
Brake_efficiency(i)=(min(deceleration_limit_for_front_wheel_lock(i),deceleration_limit_for_rear_wheel_lock(i))*100)./(mue_peak+fr);
end

figure;plot(l1,Kbf,'DisplayName','Kbf');hold on;plot(l1,Kbr,'DisplayName','Kbr');hold off;
title("l1 vs Kbf, Kbr")
xlabel("l1")
ylabel("Kbf & Kbr")
legend

figure;plot(h,Kbf,'DisplayName','Kbf');hold on;plot(h,Kbr,'DisplayName','Kbr');hold off;
title("h vs Kbf, Kbr")
xlabel("h")
ylabel("Kbf & Kbr")
legend

figure;plot(Kbf,deceleration_limit_for_front_wheel_lock,'DisplayName','Kbf');hold on;plot(Kbf,deceleration_limit_for_rear_wheel_lock,'DisplayName','Kbr');hold off;
title("Kbf vs deceleration limit for front wheel lock, deceleration limitfor rear wheel lock")
xlabel("Kbf")
ylabel("deceleration limit for front wheel lock & deceleration limit for rear wheel lock")
legend

figure;plot(l1,deceleration_limit_for_front_wheel_lock,'DisplayName','Kbf');hold on;plot(l1,deceleration_limit_for_rear_wheel_lock,'DisplayName','Kbr');hold off;
title("l1 vs deceleration limit for front wheel lock, deceleration limit for rear wheel lock")
xlabel("l1")
ylabel("deceleration limit for front wheel lock & deceleration limit for rear wheel lock")
legend

figure;plot(h,deceleration_limit_for_front_wheel_lock,'DisplayName','Kbf');hold on;plot(h,deceleration_limit_for_rear_wheel_lock,'DisplayName','Kbr');hold off;
title("h vs deceleration limit for front wheel lock, deceleration limit for rear wheel lock")
xlabel("h")
ylabel("deceleration limit for front wheel lock & deceleration limit for rear wheel lock")
legend