# Análise de Desempenho de Motor de Indução

Este projeto foi desenvolvido como parte do **Segundo Trabalho de Simulação** da disciplina **ELE085 – Conversores Eletromecânicos**, no curso de Engenharia Elétrica da UFMG.

## Descrição

O código simula o comportamento de um motor de indução trifásico a partir do circuito equivalente de regime permanente. Utiliza os parâmetros extraídos do bloco `Asynchronous Machine SI Units` do Simulink, modelo Preset Model 7.

São realizadas análises do ponto de operação nominal e de operação com escorregamento variando, permitindo avaliar:

- Desempenho elétrico (corrente, potência, fator de potência)
- Desempenho mecânico (torque, velocidade, potência mecânica)
- Eficiência da máquina

## Geração de Curvas

As curvas geradas são:

- **Torque vs Velocidade Mecânica**
- **Corrente do Estator vs Velocidade Mecânica**
- **Eficiência vs Potência Mecânica**
- **Fator de Potência vs Potência Mecânica**
- **Escorregamento vs Potência Mecânica**
- **Corrente do Estator vs Potência Mecânica**

## 🚀 Como executar

1. Instale as dependências:
```bash
pip install numpy matplotlib

