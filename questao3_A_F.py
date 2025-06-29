import numpy as np
import matplotlib.pyplot as plt

# Parâmetros do motor (Preset Model 7)
potencia_nominal_W = 149200      # Potência nominal (W)
tensao_linha_V = 460             # Tensão de linha (V)
frequencia_Hz = 60               # Frequência (Hz)
numero_polos = 2                 # Número de polos

resistencia_estator_ohm = 0.01818
resistencia_rotor_ohm = 0.009956
indutancia_disp_estator_H = 0.00019
indutancia_disp_rotor_H = 0.00019
indutancia_magnetizacao_H = 0.009415

velocidade_sincrona_rad_s = 2 * np.pi * frequencia_Hz / (numero_polos / 2)

tensao_fase_V = tensao_linha_V / np.sqrt(3)

escorregamento = np.arange(0.001, 1.001, 0.001)

j = 1j
impedancia_estator = resistencia_estator_ohm + j * 2 * np.pi * frequencia_Hz * indutancia_disp_estator_H
impedancia_magnetizacao = j * 2 * np.pi * frequencia_Hz * indutancia_magnetizacao_H
impedancia_rotor = resistencia_rotor_ohm / escorregamento + j * 2 * np.pi * frequencia_Hz * indutancia_disp_rotor_H

# Circuito equivalente Thevenin
impedancia_thevenin = (impedancia_estator * impedancia_magnetizacao) / (impedancia_estator + impedancia_magnetizacao)
tensao_thevenin = tensao_fase_V * (impedancia_magnetizacao / (impedancia_estator + impedancia_magnetizacao))

# Corrente do rotor
corrente_rotor = tensao_thevenin / (impedancia_thevenin + impedancia_rotor)

# Potência convertida em potência mecânica
potencia_convertida_W = 3 * abs(corrente_rotor)**2 * resistencia_rotor_ohm / escorregamento

# Torque
torque_Nm = potencia_convertida_W / velocidade_sincrona_rad_s

# Velocidade mecânica
velocidade_mecanica_rad_s = (1 - escorregamento) * velocidade_sincrona_rad_s

# Corrente no estator
impedancia_equivalente = impedancia_estator + (impedancia_magnetizacao * impedancia_rotor) / (impedancia_magnetizacao + impedancia_rotor)
corrente_estator = tensao_fase_V / impedancia_equivalente


# Configurações dos gráficos
title_fs = 22
label_fs = 20
tick_fs = 18
line_width = 3.5

def configurar_grafico(title, xlabel, ylabel):
    plt.title(title, fontsize=title_fs)
    plt.xlabel(xlabel, fontsize=label_fs)
    plt.ylabel(ylabel, fontsize=label_fs)
    plt.grid(True)
    plt.xticks(fontsize=tick_fs)
    plt.yticks(fontsize=tick_fs)


# a) Torque vs Velocidade Mecânica
plt.figure()
plt.plot(velocidade_mecanica_rad_s, torque_Nm, linewidth=line_width, color='red')
configurar_grafico("a) Torque vs Velocidade Mecânica", "Velocidade mecânica (rad/s)", "Torque (Nm)")

# b) Corrente no Estator vs Velocidade Mecânica
plt.figure()
plt.plot(velocidade_mecanica_rad_s, abs(corrente_estator), linewidth=line_width, color='red')
configurar_grafico("b) Corrente no Estator vs Velocidade Mecânica", "Velocidade mecânica (rad/s)", "Corrente no estator |I1| (A)")

# Encontrar escorregamento de torque máximo
indice_torque_maximo = np.argmax(torque_Nm)
escorregamento_torque_maximo = escorregamento[indice_torque_maximo]

# Recalcular para curva operacional (do ponto de torque máximo até escorregamento 1)
escorregamento_operacional = np.arange(escorregamento_torque_maximo, 1.001, 0.001)
impedancia_rotor_operacional = resistencia_rotor_ohm / escorregamento_operacional + j * 2 * np.pi * frequencia_Hz * indutancia_disp_rotor_H
impedancia_equivalente_operacional = impedancia_estator + (impedancia_magnetizacao * impedancia_rotor_operacional) / (impedancia_magnetizacao + impedancia_rotor_operacional)
corrente_estator_operacional = tensao_fase_V / impedancia_equivalente_operacional
corrente_rotor_operacional = tensao_thevenin / (impedancia_thevenin + impedancia_rotor_operacional)

potencia_convertida_operacional_W = 3 * abs(corrente_rotor_operacional)**2 * resistencia_rotor_ohm / escorregamento_operacional
torque_operacional_Nm = potencia_convertida_operacional_W / velocidade_sincrona_rad_s
velocidade_mecanica_operacional_rad_s = (1 - escorregamento_operacional) * velocidade_sincrona_rad_s

potencia_mecanica_kW = (torque_operacional_Nm * velocidade_mecanica_operacional_rad_s) / 1000  # kW

potencia_entrada = 3 * tensao_fase_V * np.conj(corrente_estator_operacional)
fator_potencia = np.cos(np.angle(potencia_entrada))
eficiencia = (potencia_mecanica_kW * 1000) / np.real(potencia_entrada)


# c) Eficiência vs Potência Mecânica
plt.figure()
plt.plot(potencia_mecanica_kW, eficiencia * 100, linewidth=line_width, color='red')
configurar_grafico("c) Eficiência vs Potência Mecânica", "Potência Mecânica (kW)", "Eficiência (%)")

# d) Fator de Potência vs Potência Mecânica
plt.figure()
plt.plot(potencia_mecanica_kW, fator_potencia, linewidth=line_width, color='red')
configurar_grafico("d) Fator de Potência vs Potência Mecânica", "Potência Mecânica (kW)", "Fator de Potência")

# e) Escorregamento vs Potência Mecânica
plt.figure()
plt.plot(potencia_mecanica_kW, escorregamento_operacional, linewidth=line_width, color='red')
configurar_grafico("e) Escorregamento vs Potência Mecânica", "Potência Mecânica (kW)", "Escorregamento")

# f) Corrente no Estator vs Potência Mecânica
plt.figure()
plt.plot(potencia_mecanica_kW, abs(corrente_estator_operacional), linewidth=line_width, color='red')
configurar_grafico("f) Corrente no Estator vs Potência Mecânica", "Potência Mecânica (kW)", "Corrente no Estator |I1| (A)")

plt.show()


# Informações adicionais
print(f"Escorregamento de torque máximo (s_Tmax): {escorregamento_torque_maximo:.3f}")
print(f"Torque máximo (Tmax): {np.max(torque_Nm):.2f} Nm")
