%mary oji 101036761 
%umeh ifeanyi 101045786
Is = 0.01e-12;
Ib = 0.1e-12;
Vb = 1.3; 
Gp = 0.1; 

%part 1
V = linspace(-1.95,0.7,200);
I = (Is*(exp(1.2*V/0.025)-1)) + (Gp*V) - (Ib*(exp(-1.2*(V+Vb)/0.025)-1));
r = (1.2-0.8).*rand(size(I)) + 0.8;
I20 = r.*I;
figure('name','Part1')
subplot(2,1,1)
plot(V,I,V,I20)
subplot(2,1,2)
semilogy(V,abs(I),V,abs(I20))

%part 2
p4 = polyfit(V,I,4);
p8 = polyfit(V,I,8);
pv4 = polyval(p4,V);
pv8 = polyval(p8,V);
p420 = polyfit(V,I20,4);
p820 = polyfit(V,I20,8);
pv420 = polyval(p420,V);
pv820 = polyval(p820,V);
figure('name','Part2')
subplot(2,2,1)
plot(V,I,'r',V,pv4,'b')
title('no nosie p4')
subplot(2,2,2)
plot(V,I,'r',V,pv8,'b')
title('no nosie p8')
subplot(2,2,3)
semilogy(V,abs(I),'r',V,abs(pv420),'b')
title('nosie p4')
subplot(2,2,4)
semilogy(V,abs(I),'r',V,abs(pv820),'b')
title('nosie p8')

%part 3
fo1 = fittype('A*(exp(1.2*x/0.025)-1) + (0.1*x) - (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ff1 = fit(V',I',fo1);
If1 = ff1(V);
fo2 = fittype('A*(exp(1.2*x/0.025)-1) + (B*x) - (C*(exp(-1.2*(x+1.3)/0.025)-1))');
ff2 = fit(V',I',fo2);
If2 = ff2(V);
fo3 = fittype('A*(exp(1.2*x/0.025)-1) + (B*x) - (C*(exp(-1.2*(x+D)/0.025)-1))');
ff3 = fit(V',I',fo3);
If3 = ff3(V);
figure('name','Part3')
subplot(3,1,1)
semilogy(V,abs(If1'),'b',V,abs(I20),'r')
title('2 fitted')
subplot(3,1,2)
semilogy(V,abs(If2'),'b',V,abs(I20),'r')
title('3 fitted')
subplot(3,1,3)
semilogy(V,abs(If3'),'b',V,abs(I20),'r')
title('4 fitted')

%part 4
inputs = V.';
targets = I.';
hiddenLayerSize = 10;
net = fitnet(hiddenLayerSize); net.divideParam.trainRatio = 70/100; net.divideParam.valRatio = 15/100; net.divideParam.testRatio = 15/100; [net,tr] = train(net,inputs,targets);
outputs = net(inputs);
errors = gsubtract(outputs,targets); performance = perform(net,targets,outputs); view(net)
Inn = outputs;
figure('name','part4')
subplot(2,1,1)
plot(inputs,Inn,'b',inputs,I20,'r')
subplot(2,1,2)
semilogy(inputs,abs(Inn),'b',inputs,abs(I20),'r')