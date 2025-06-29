import numpy as np
import cmath

# ------------------------
# Dados do motor (Preset Model 7)
# ------------------------

# Constantes do circuito equivalente por fase
Rs = 0.01818        # Resistência do estator (ohm)
Rr_ = 0.009956      # Resistência do rotor referida ao estator (ohm)
Lls = 0.00019       # Indutância de dispersão do estator (H)
Llr_ = 0.00019      # Indutância de dispersão do rotor (H)
Lm = 0.009415       # Indutância de magnetização (H)
f = 60              # Frequência (Hz)
V_linha = 460       # Tensão de linha (V)
Vf = V_linha / np.sqrt(3)  # Tensão de fase

# Frequência angular
we = 2 * np.pi * f

# Reatâncias
Xs = we * Lls
Xr = we * Llr_
Xm = we * Lm

# Impedâncias
Zs = complex(Rs, Xs)
Ym = complex(0, 1 / Xm)

# ------------------------
# Corrente de partida (s = 1)
# ------------------------

s_partida = 1.0
Zr_partida = complex(Rr_ / s_partida, Xr)
Zparalelo_partida = 1 / (1 / Zr_partida + Ym)
Zeq_partida = Zs + Zparalelo_partida
I1_partida = Vf / Zeq_partida
I1p_mag = abs(I1_partida)

# ------------------------
# Corrente nominal (s = 0.00833)
# ------------------------

s_nominal = 0.00833
Zr_nominal = complex(Rr_ / s_nominal, Xr)
Zparalelo_nominal = 1 / (1 / Zr_nominal + Ym)
Zeq_nominal = Zs + Zparalelo_nominal
I1_nominal = Vf / Zeq_nominal
I1n_mag = abs(I1_nominal)

# ------------------------
# Razão entre correntes
# ------------------------

razao = I1p_mag / I1n_mag

# ------------------------
# Resultados
# ------------------------

print(f"Corrente de partida |i1,p| = {I1p_mag:.2f} A")
print(f"Corrente nominal   |i1,nom| = {I1n_mag:.2f} A")
print(f"Razão |i1,p| / |i1,nom| = {razao:.2f}")

