Density_air = 1.1;

Dense = Density_air;

%data vectors

Rdat = [153.8 ./ 2, 214.3 ./ 2, 324.4 ./ 2, 380.3 ./ 2];
tdat = [0.006, 0.016, 0.053, 0.1];

rho = zeros(4,1) + Dense;
Energy_Test=Energy(300,2,0.01);

energies = zeros(1,4);

energies2 = 1:4;

energies3=Energy(Rdat,rho,tdat);


for i=1:4
    energies(i)=Energy(Rdat(i),rho(i),tdat(i));
end

plot(energies);

for i=1:4
    sur(i)= 1.077 .* energies(i)
end

avg=sum(sur) ./ 4;