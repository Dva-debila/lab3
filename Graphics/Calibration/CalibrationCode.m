Imp0 = importdata("experimentData\calibzero.dat");
Imp68 = importdata("experimentData\calib.dat");

Adc0 = Imp0(:,2);
Adc68 = Imp68(:,2);
P0 = ones(length(Adc0),1)*0;
P68 = ones(length(Adc68),1)*68;

Adc = [Adc0; Adc68];
P = [P0; P68];

c = polyfit(Adc, P, 1);
cFigure = figure('Name','Calibration','NumberTitle','off');
hold all;

plot(Adc0,P0,'.','MarkerSize', 20,'Color',[0,0,1]);
plot(Adc68,P68,'.','MarkerSize', 20,'Color',[1,1,0]);
plot(Adc,polyval(c,Adc));

legend('0 Па','68 Па','Калибровочная зависимость','Location','NorthWest');
grid on;
xlabel('Отсчёты АЦП');
ylabel('\DeltaP, Па');
title('Калибровка');
text(mean(Adc)*0.9,mean(P)*0.7,['\DeltaP(adc) = ', num2str(c(1)),' * adc + ',num2str(c(2)),' [Па]']);

settings = fopen('settings.txt','w');
fprintf(settings,'%f\n',c(1), c(2));
fclose(settings);

saveas(cFigure, 'CalibrationGraph.png');