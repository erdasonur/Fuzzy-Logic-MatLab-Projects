S=[0 25 50 75 100 125 150 175 200]
T=[0 10 20 30 40 50]
for i=1:length(S)
    for j=1:length(T)
        plot3(S(i),T(j),Mamdani(S(i),T(j)),'*');
        hold on
        
    end
end

xlabel('Gun Isigi Seviyesi(mW/cm^2)');
ylabel('Sicaklik');
zlabel('Maksimum guc degeri');
grid


