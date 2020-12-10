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
vFW = WaterI.data;
[s1,s2] = size(Air);
Traw = transpose(linspace(0, Time, s1));
T = (1:size(Air(:,1)))/Freq;

hold all;

windowSize = 5;
b = (1 / windowSize) * ones(1, windowSize);
a = 1;

airFiltered = filter(b, a, Air());
breathFiltered = filter(b, a, Breath());

start = 30;

airFiltered = airFiltered(start:end, :);
breathFiltered = breathFiltered(start:end, :);
T = Traw(start:end);

cAir = polyfit(T, airFiltered(:, 1), 3);
cBreath = polyfit(T, breathFiltered(:, 1), 3);

air = airFiltered - polyval(cAir, T);
AirNorm = air ./ max(air);

breath = breathFiltered - polyval(cBreath, T);
BreathNorm = breath ./ max(breath);
plot(T,AirNorm(:,1),'Color',[0,0,1],'LineWidth',0.5);
plot(T,AirNorm(:,2),'Color',[1,0,0],'LineWidth',0.5);
legend('Микрофон №1','Микрофон №2');
grid on;
xlabel("Время, с");
ylabel("Отсчёта АЦП");
title(["Относительное измерение давления у микрофонов","в воздухе"]);
saveas(gca,"air.png");
hold off;


plot(T,BreathNorm(:,1),'Color',[0,0,1],'LineWidth',0.5);
hold all;
plot(T,BreathNorm(:,2),'Color',[1,0,0],'LineWidth',0.5);
legend('Микрофон №1','Микрофон №2');
grid on;
xlabel("Время, с");
ylabel("Отсчёта АЦП");
title(["Относительное измерение давления у микрофонов","в воздухе из лёгких"]);
saveas(gca,"breath.png");

mA = find(AirNorm == max(AirNorm));
mB = find(BreathNorm == max(BreathNorm));
tA1 = T(mA(1));
tA2 = T(mA(2)-995);
tB1 = T(mB(1));
tB2 = T(mB(2)-995);
vA = 1.158/(tA2-tA1);
vB = 1.158/(tB2-tB1);
temp = Temp + 273.14;
x_CO2 = linspace(0, 0.02);
q = 1 - vFW - x_CO2;
mu = 28.97.*q + 18.01*vFW + 44.01.*x_CO2;
R = 8.314;
g = (28.97*1.0036.*q + 18.01*1.863*vFW + 44.01*0.838.*x_CO2)./(28.97*0.7166.*q + 18.01*1.403*vFW + 44.01*0.649.*x_CO2);
v = sqrt(1000 * R .* g * temp ./ mu);
v11 = ones(100)*vB;

hold off;
plot(x_CO2,v,'b',x_CO2,v11,'r');
c0 = polyfit(x_CO2, v, 1);
x0 = (v11(1,1)-c0(2))/c0(1);
grid on;
xlabel("Доля CO_2");
ylabel("Скорость звука, м/с");
title({["Зависимость скорости звука от объёмной доли CO_2"],['Коорд. точки пересечения: (', num2str(x0),',', num2str(v(1,1)),')']});
legend('Скорость звука в зависимости от содержания CO_{2}', 'Рассчитанная экспериментальная скорость звука');
saveas(gca,"result.png");