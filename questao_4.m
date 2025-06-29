clc;
clear;
close all;

% Parâmetros do motor de indução calcular valores de torque e velocidade

Vn = 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn = 60;            % Frequência nominal (Hz)
polos = 2;          % Número de pares de polos
we=377;             % frequencia angular de alimentação em rad/s
Ns = 120*fn/(2*polos);  % Velocidade síncrona da máquina em RPM
ws= 2*pi*fn/polos;  % Frequência angular síncrona 
s= 0.001:0.001:1;   % escorregamento
Pn=1.492e+05;             % Potencia mecânica = Potencia de saida
Rth= 0.01818;       % Rs Resistência de thevenin
R2= 0.009956;       % Rr 
Lls= 0.00019;
Xth=we*Lls;         % Relutância de thevenin
Llr= 0.00019;       
X2= we*Llr;      
Lm=0.009415;
Xm= we*Lm;
j=sqrt(-1);         % Número imaginário
Vth= abs(j*Xm/(j*we*Lls+Rth+j*we*Lm)*Vn); % tensão de thevenin

%%%%%%%%%%%%%%%%%% LETRA A %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec= Ns-s.*Ns; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind= (3*Vth^2*(R2./s))./(ws*((Rth+(R2./s)).^2+(Xth+X2)^2));


%%%%%%%%%%%%%%%%%% LETRA B %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn_b = 0.75* 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn_b = 0.75*60;
Ns_b = 120*fn_b/(2*polos);  % Velocidade síncrona da máquina em RPM
ws_b= 2*pi*fn_b/polos;  % Frequência angular síncrona 
Xth_b=we*Lls;         % Relutância de thevenin
X2_b= we*Llr;  
Xm_b= we*Lm;
Vth_b= abs(j*Xm_b/(j*we*Lls+Rth+j*we*Lm)*Vn_b);

% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec_b= Ns_b-s.*Ns_b; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind_b= (3*Vth_b^2*(R2./s))./(ws_b*((Rth+(R2./s)).^2+(Xth_b+X2_b)^2));


%%%%%%%%%%%%%%%%%% LETRA C %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn_c = 0.625* 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn_c = 0.625*60;
Ns_c = 120*fn_c/(2*polos);  % Velocidade síncrona da máquina em RPM
ws_c= 2*pi*fn_c/polos;  % Frequência angular síncrona 
Xth_c=we*Lls;         % Relutância de thevenin
X2_c= we*Llr;  
Xm_c= we*Lm;
Vth_c= abs(j*Xm_c/(j*we*Lls+Rth+j*we*Lm)*Vn_c);

% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec_c= Ns_c-s.*Ns_c; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind_c= (3*Vth_c^2*(R2./s))./(ws_c*((Rth+(R2./s)).^2+(Xth_c+X2_c)^2));


%%%%%%%%%%%%%%%%%% LETRA D %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn_d = 0.5* 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn_d = 0.5*60;
Ns_d = 120*fn_d/(2*polos);  % Velocidade síncrona da máquina em RPM
ws_d= 2*pi*fn_d/polos;  % Frequência angular síncrona 
Xth_d=we*Lls;         % Relutância de thevenin
X2_d= we*Llr;  
Xm_d= we*Lm;
Vth_d= abs(j*Xm_d/(j*we*Lls+Rth+j*we*Lm)*Vn_d);

% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec_d= Ns_d-s.*Ns_d; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind_d= (3*Vth_d^2*(R2./s))./(ws_d*((Rth+(R2./s)).^2+(Xth_d+X2_d)^2));


%%%%%%%%%%%%%%%%%% LETRA E %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn_e = 0.375* 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn_e = 0.375*60;
Ns_e = 120*fn_e/(2*polos);  % Velocidade síncrona da máquina em RPM
ws_e= 2*pi*fn_e/polos;  % Frequência angular síncrona 
Xth_e=we*Lls;         % Relutância de thevenin
X2_e= we*Llr;  
Xm_e= we*Lm;
Vth_e= abs(j*Xm_e/(j*we*Lls+Rth+j*we*Lm)*Vn_e);

% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec_e= Ns_e-s.*Ns_e; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind_e= (3*Vth_e^2*(R2./s))./(ws_e*((Rth+(R2./s)).^2+(Xth_e+X2_e)^2));


%%%%%%%%%%%%%%%%%% LETRA F %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Vn_f = 0.25* 460/sqrt(3);   % Tensão de fase nominal (V) - ligação Y
fn_f = 0.25*60;
Ns_f = 120*fn_f/(2*polos);  % Velocidade síncrona da máquina em RPM
ws_f= 2*pi*fn_f/polos;  % Frequência angular síncrona 
Xth_f=we*Lls;         % Relutância de thevenin
X2_f= we*Llr;  
Xm_f= we*Lm;
Vth_f= abs(j*Xm_f/(j*we*Lls+Rth+j*we*Lm)*Vn_f);

% CALCULO DA VELOCIDADE MECÂNICA EM RPM 
Nmec_f= Ns_f-s.*Ns_f; % Velocidade mecânica

%CALCULO DO TORQUE EM Nm 
Tind_f= (3*Vth_f^2*(R2./s))./(ws_f*((Rth+(R2./s)).^2+(Xth_f+X2_f)^2));

%%%%%%%%%%%%%%%%%% PLOTAGEM DO GRÁFICO %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Plot comparativo
figure;
hold on;
plot(Nmec, Tind, 'b', 'LineWidth', 2, 'DisplayName', '100% Vn/fn');
plot(Nmec_b, Tind_b, 'r', 'LineWidth', 2, 'DisplayName', '75% Vn/fn');
plot(Nmec_c, Tind_c, 'g', 'LineWidth', 2, 'DisplayName', '62.5% Vn/fn');
plot(Nmec_d, Tind_d, 'm', 'LineWidth', 2, 'DisplayName', '50% Vn/fn');
plot(Nmec_e, Tind_e, 'c', 'LineWidth', 2, 'DisplayName', '37.5% Vn/fn');
plot(Nmec_f, Tind_f, 'k', 'LineWidth', 2, 'DisplayName', '25% Vn/fn');

grid on;
xlabel('Velocidade Mecânica (rpm)');
ylabel('Torque (Nm)');
title('Comparação de Curvas Torque vs Velocidade para Diferentes Níveis de Alimentação');
legend('Location', 'best');
xlim([0 max(Nmec)]);
hold off;