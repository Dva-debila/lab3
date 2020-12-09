AirI = importdata("data\air.txt");
BreathI = importdata("data\breath.txt");
FreqI = importdata("data\samplingFrequency.txt");
TempI = importdata("data\temperature.txt");
TimeI = importdata("data\totalTime.txt");
WaterI = importdata("data\volumeFractionWater.txt");

Air = AirI.data;
Breath = BreathI.data;
Freq = FreqI.data;
Temp = TempI.data;
Time = TimeI.data;
Water = WaterI.data;

T = (1:size(Air(:,1)))/Freq;

hold all;

cAir1 = polyfit(T,Air(:,1),1);
cAir2 = polyfit(T,Air(:,2),1);
AirO(:,1) = Air(:,1) - polyval(cAir1,T)';
AirO(:,2) = Air(:,2) - polyval(cAir2,T)';
AirNorm = AirO ./ max(AirO);
plot(T,AirNorm(:,1),'Color',[0,0,1],'LineWidth',0.5);
plot(T,AirNorm(:,2),'Color',[1,0,0],'LineWidth',0.5);
legend('Микрофон №1','Микрофон №2');
grid on;
xlabel("Время, с");
ylabel("Отсчёта АЦП");
title(["Относительное измерение давления у микрофонов","в воздухе"]);
saveas(gca,"air.png");
hold off;

cBreath1 = polyfit(T,Breath(:,1),1);
cBreath2 = polyfit(T,Breath(:,2),1);
BreathO(:,1) = Breath(:,1) - polyval(cBreath1,T)';
BreathO(:,2) = Breath(:,2) - polyval(cBreath2,T)';
BreathNorm = BreathO ./ max(BreathO);
plot(T,BreathNorm(:,1),'Color',[0,0,1],'LineWidth',0.5);
hold all;
plot(T,BreathNorm(:,2),'Color',[1,0,0],'LineWidth',0.5);
legend('Микрофон №1','Микрофон №2');
grid on;
xlabel("Время, с");
ylabel("Отсчёта АЦП");
title(["Относительное измерение давления у микрофонов","в воздухе из лёгких"]);
saveas(gca,"breath.png");

