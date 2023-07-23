lw x5, a # x5 =a
lw x6, b # x6 =b
lw x7, c # x7 =c
lw x8, zero_ # a4==0 // x = 0 
sw a1, a
sw a2, b

sw a3, c
sw a4, zero_

lw x1, quinze
lw x2, um
lw x3, zero_
lw x4, meia2

#testando c
slt t3, x7, x1 # se c < 15, t3 = 1
beq t3,x2, fim # se for menor acaba o programa
beq x7, x1, fim # se c = 15 fim do programa
# o programa so chega nessa linha se c>15

#testando a
slt t1, x5,x3 # se a < 0, t1 =1
beq t1,x2, fim # se a<0 acaba o problema 
#so chega aqui se a >=0 e c>15

#testando b
slt t2, x6, x4 #se b <62, t2=1
beq t2,x3, teste_b #se b >= 62, ir para teste
#so chega aqui se b<62, a >=0 e c>15
jal a7, certo 

teste_b:
    beq x6, x4, certo #se chegar aqui b= 62, a>0 e c>15 (dá certo)
    jal a7, fim #se chegar aqui b>62, a>0 e c>15 (dá errado)

certo:
    lw x8, um
    sw x8, um
    jal a6, fim
    
fim:
    halt 

a: .word 3
b: .word 20
c: .word 16
um: .word 1
quinze: .word 15
meia2: .word 62

zero_: .word 0
