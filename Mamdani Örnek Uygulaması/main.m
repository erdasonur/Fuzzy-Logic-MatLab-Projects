S=[0 25 50 75 100 125 150 175 200]
T=[0 10 20 30 40 50]

fprintf('S/T');
        for i=1:length(T)
            fprintf('   %d     ',T(i));
        end
        fprintf('\n')
for i=1:length(S)
    
        for j=0:length(T)
            if j==0
                fprintf('%d ',S(i));
            end
            if j>0
                fprintf(' %f ',Mamdani(S(i),T(j)));
            end
        end
    fprintf('\n');
end



