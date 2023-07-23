lw a1, a # a1 =a
lw a2, b # a2 =b
lw a3, c # a3 =c
lw a4, zero # a4==0 // x = 0 
sw a1, 0(a1)
sw a2, 0(a2)

sw a3, 0(a3)
sw a4, 0(a4)

#testando c
slt t3, a3, 15 # se a3 < 15, t3 = 1
beq t3,1, fim # se for menor acaba o programa
beq a3, 15, fim # se a3 = 15 fim do programa
# o programa so chega nessa linha se c>15

#testando a
slt t1, a1,0 # se a1 < 0, t1 =1
beq t1,1, fim # se a<0 acaba o problema 
#so chega aqui se a >=0 e c>15

#testando b
slt t2, a2, 62 #se a2 <62, t2=1
beq t2,0, teste_b #se a2 >= 62, ir para teste
#so chega aqui se b<62, a >=0 e c>15
jal a7, certo 

teste_b:
    beq a2, 62, certo #se chegar aqui b= 62, a>0 e c>15 (dá certo)
    jal a7, fim #se chegar aqui b>62, a>0 e c>15 (dá errado)

certo:
    lw a4, x
    sw a4, 0(a4)
    jal a6, fim
    
fim:
    halt 

a: .word 0d3
b: .word 0d20
c: .word 0d10
x: .word 0d1
