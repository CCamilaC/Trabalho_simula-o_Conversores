clc;
clear;
close all;

% Parâmetros do motor de indução calcular valores de torque e velocidade

Vn = 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn = 60;            % Frequência nominal (Hz)
polos = 2;          % Número de pares de polos

Ns = 120*fn/(2*polos);  % Velocidade síncrona da máquina em RPM
ws= 2*pi*fn/polos;  % Frequência angular síncrona 
Nmec= 1785;         % Velocidade mecânica

%Escorregamento nominal (sn)
sn=(Ns-Nmec)/Ns; 
% Vetor escorregamento
s=0.001:0.001:1;   

Nnom = (1-sn)*Ns; % frequencia nominal rpm
wm_nom = Nnom*2*pi/60; %frequencia angular nominal rad/s
we=377;             % frequencia angular de alimentação em rad/s
wmec=2*pi*Nmec/60;  % Velocidade angular mecânica rad/s

Pn= 1.492e+05;      %Potência mecânica ou de saída (W)

%Relutâncias
Rth= 0.01818;       % Rs Resistência de thevenin
R2= 0.009956;       % Rr 
Lls= 0.00019;
Xth=we*Lls;         % Relutância de thevenin
Llr= 0.00019;       
X2= we*Llr;      
Lm=0.009415;
Xm= we*Lm;
j=sqrt(-1);         % Número imaginário

%Tensão de thevenin
Vth= abs(j*Xm*Vn/(j*we*Lls+Rth+j*we*Lm));

%Vetor tensão induzida
Tind= (3*Vth^2*(R2./s))./(ws*((Rth+(R2./s)).^2+(Xth+X2)^2));



%%%%%%%%%%%%%%%%%%%    LETRA I     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

%CALCULO DO TORQUE DE PARTIDA EM Nm 
Tind_part= (3*Vth^2*(R2/1))/(ws*((Rth+(R2/1))^2+(Xth+X2)^2));
           
fprintf('Resposta letra i -Torque de partida: %.2f Nm\n', Tind_part);

%%%%%%%%%%%%%%%%%%%    LETRA J     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

Tind_nom = Pn / wm_nom;

resp=Tind_part/Tind_nom;


fprintf('Resposta letra j - Razão Tind_part/Tind_nom : %.2f\n', resp);

%%%%%%%%%%%%%%%%%%%    LETRA K     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Relutâncias 
Z2 = R2./s + 1j*X2;
Zeq = (Rth+j*Xth) + (Z2*j*Xm)./(Z2+(j*Xm));

I1=Vn./Zeq; %cálculo do vetor de corrente

iTmax = find(Tind == max(Tind), 1, 'first');
i1Tmax = I1(iTmax);
fprintf('Resposta letra k - Corrente de torque máximo: %.2f A\n', i1Tmax);

%%%%%%%%%%%%%%%%%%%    LETRA L     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Corrente do estator nominal (I1)
I1_nom  = Vth/(sqrt((Rth+(R2/sn))^2+(Xth+X2)^2));

resp_l=i1Tmax/I1_nom;

fprintf('Resposta letra l - Razão i1Tmax/I1_nom: %.2f \n', resp_l);
%%%%%%%%%%%%%%%%%%%    LETRA M     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Escorregamento máximo
s_max= R2/sqrt((Rth^2)+(Xth+X2)^2);

%Torque máximo
Tind_max=(3*Vth^2*(R2/s_max))/(ws*((Rth+(R2/s_max))^2+(Xth+X2)^2));

fprintf('Resposta letra l - Torque máximo: %.2f A\n', Tind_max);

%%%%%%%%%%%%%%%%%%%    LETRA N     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

fprintf('Resposta letra n - Escorregamento máximo: %.4f\n', s_max);

%%%%%%%%%%%%%%%%%%%    LETRA O     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

resp_o=Tind_max/Tind_nom;
fprintf('Resposta letra o - Razão Tind_max/Tind_nom: %.2f \n', resp_o);

%%%%%%%%%%%%%%%%%%%    LETRA P     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

s=0.001; %sem carga

Vth_fas= j*Xm*Vn/(j*we*Lls+Rth+j*we*Lm);

% Fasor de corrente sem carga
Z2_vazio = R2/s + 1j*X2;
Zeq_vazio = (Rth+j*Xth) + (Z2_vazio*j*Xm)/(Z2_vazio+(j*Xm));

i=Vth_fas/Zeq_vazio;
magnitude_i = abs(i);
fase_i_rad = angle(i);
fase_i_deg = rad2deg(fase_i_rad);

% Imprime como fasor
fprintf('Resposta letra p - Fasor da corrente a vazio: %.2f ∠ %.2f° A\n', magnitude_i, fase_i_deg);

%%%%%%%%%%%%%%%%%%%    LETRA Q     %%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Fator de potência sem carga
FP=cos(fase_i_deg);

% Imprime 
fprintf('Resposta letra q - Fator de potência a vazio: %.2f° \n', FP);

%%%%%%%%%%%%%%%%%%%    DEMAIS DADOS     %%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('Demais dados cáculados:\n');
fprintf('Escorregamento nominal: %.4f\n', sn);
fprintf('Torque nominal: %.2f Nm\n', Tind_nom);