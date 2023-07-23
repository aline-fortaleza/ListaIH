main:
    lw a1, a # a1 =a
    lw a2, b # a2 =b
    lw a3, c # a3 =c
    lw a4, zero # a4==0 // x = 0 
    sw a1, 0(a1)
    sw a2, 0(a2)
    sw a3, 0(a3)
    sw a4, 0(a4)

    slt t1, a1, 0 # se a1 < 0, t1 = 1 // fazendo o inverso pra n precisar testar o igual
    sgt t2, a2, 62 # se a2 > 62 , t2 = 1 // fazendo o inverso pra n precisar testar o igual
    sgt t3, a3, 15 # se a3 > 15,  t3 = 1

    #Para entrar na condicional precisamos que t1=0, t2=0 e t3= 1
    beq t1,0, teste_b
    j fim

    teste_b:
    beq t2,0, teste_c
    j fim 

    teste_c:
    beq t3, 0, fim
    lw a4, 1 
    sw a4, 0(a4)
    j fim 


fim:
halt 

a: .word 0d3
b: .word 0d20
c: .word 0d10