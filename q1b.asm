#lw x5, a # x5 =a
#lw x6, b # x6 =b
#lw x7, c # x7 =c
#lw x8, zero_ # a4==0 // x = 0 
#sw a1, a
#sw a2, b

#sw a3, c
#sw a4, zero_

lw x1, quinze
lw x2, um
lw x3, zero_
lw x4, meia2
lw x5, enter
lw x6, space
lw x7, zero_ # contador do get
lw x8, zero_ # contador do prox
lw x9, tres 
lw x10, zero_ # contador guardar
lw x13, dois 
lw x19, zero_ # contador do mult 10
lw  x20, zero_ # contador do mult 100
lw x21, dez 
lw x27, cem




aritmetica:
    #testando c
    slt t3, x29, x1 # se c < 15, t3 = 1
    beq t3,x2, errado # se for menor acaba o programa
    beq x29, x1, errado # se c = 15 fim do programa
    # o programa so chega nessa linha se c>15

    #testando a
    slt t1, x17,x3 # se a < 0, t1 =1
    beq t1,x2, errado # se a<0 acaba o problema 
    #so chega aqui se a >=0 e c>15

    #testando b
    slt t2, x28, x4 #se b <62, t2=1
    beq t2,x3, teste_b #se b >= 62, ir para teste
    #so chega aqui se b<62, a >=0 e c>15
    jal a7, certo 

teste_b:
    beq x28, x4, certo #se chegar aqui b= 62, a>0 e c>15 (dá certo)
    jal a7, errado #se chegar aqui b>62, a>0 e c>15 (dá errado)

certo:
    lw x8, um
    sw x8, um
    lw x11, um_char
    lb x11, 1024(x0)
    ecall
    jal a6, fim

errado:
    lw x11, zero_char
    lb x11, 1024(x0)
    ecall
    jal a6,fim
    
get:
    lb x11, 1025(x0) 
    ecall
    beq x11, x5, prox_num #se apertar enter vai pro proximo numero
    beq x11, x6, prox_num #se apertar espaço vai pro proximo numero
    beq x7, x9, prox_num #se ja tiver 3 digitos pega o proximo
    addi x7, x7, 1 # aumenta contador dos numeros de digitos
    addi x11, x11, -48 #transforma o char pra inteiro 
    jal x12, guardar



prox_num:
    addi x8,x8,1 # aumenta o contador de quantos numeros temos
    beq x8, x2, in_a 
    beq x8, x13, in_b
    beq x8, x9, in_c

in_a:
    beq x7, x2, a_um
    beq x7, x13, a_dois
    beq x7, x9, a_tres

in_b:
    beq x7, x2, b_um
    beq x7, x13, b_dois
    beq x7, x9, b_tres
in_c:
    beq x7, x2, c_um
    beq x7, x13, c_dois
    beq x7, x9, c_tres

a_um:
    lw x17,x14 # x17 que eh a inteiro so tem o digito q ta em x14
    lw x7, x3 #zera o contador de get
    jal x18, get

a_dois:
    addi x22, x14, 0 # o primeiro digito de a vai pro argumento da função mult_10
    jal x23, mult_10
    lw  x17, x19 # o valor final de a recebe a parte decimal
    add x17, x15 #soma com as unidades 
    lw x7, x3 #zera o contador de get
    jal x18, get

a_tres:
    addi x24, x14, 0  # o primeiro digito de a vai pro argumento da função mult_100
    jal x26, mult_100 
    lw  x17, x24 #o valor final de a recebe a parte das centenas
    addi x22, x15, 0 # o psegundo digito de a vai pro argumento da função mult_10
    jal x23, mult_10
    add x17, x17, x19 # soma das centenas com as dezenas
    add x17, x17, x16 # soma as centenas e dezenas com as unidades 
    jal x18, get 

b_um:
    lw x28,x14 # x28 que eh a inteiro so tem o digito q ta em x14
    lw x7, x3 #zera o contador de get
    jal x18, get

b_dois:
    addi x22, x14, 0 # o primeiro digito de b vai pro argumento da função mult_10
    jal x23, mult_10
    lw  x28, x19 # o valor final de b recebe a parte decimal
    add x28, x15 #soma com as unidades 
    lw x7, x3 #zera o contador de get
    jal x18, get

b_tres:
    addi x24, x14, 0  # o primeiro digito de b vai pro argumento da função mult_100
    jal x26, mult_100 
    lw  x28, x24 #o valor final de b recebe a parte das centenas
    addi x22, x15, 0 # o psegundo digito de a vai pro argumento da função mult_10
    jal x23, mult_10
    add x28, x28, x19 # soma das centenas com as dezenas
    add x28, x28, x16 # soma as centenas e dezenas com as unidades 
    jal x18, get 

c_um:
    lw x29,x14 # x28 que eh a inteiro so tem o digito q ta em x14
    lw x7, x3 #zera o contador de get
    jal x18, aritmetica

c_dois:
    addi x22, x14, 0 # o primeiro digito de b vai pro argumento da função mult_10
    jal x23, mult_10
    lw  x29, x19 # o valor final de b recebe a parte decimal
    add x29, x15 #soma com as unidades 
    lw x7, x3 #zera o contador de get
    jal x18, aritmetica

c_tres:
    addi x24, x14, 0  # o primeiro digito de b vai pro argumento da função mult_100
    jal x26, mult_100 
    lw  x29, x24 #o valor final de b recebe a parte das centenas
    addi x22, x15, 0 # o psegundo digito de a vai pro argumento da função mult_10
    jal x23, mult_10
    add x29, x29, x19 # soma das centenas com as dezenas
    add x29, x29, x16 # soma as centenas e dezenas com as unidades 
    jal x18, aritmetica 

mult_100:
    addi x20, x20, 1 # aumenta o contador
    add x24, x24, x24
    blt x24, x27, mult_100 # ir até 100
    lw x20, x3 #zerar o contator 
    jalr ra, 0(x26)    

mult_10:
    addi x19,x19, 1 # aumenta o contador
    add x22,x22,x22
    blt x19, x21, mult_10 # ir até 10
    lw x19, x3 #zera o contador
    jalr ra, 0(x23)

guardar: 
    addi x10,x10,1 # aumenta o contador 
    beq  x10, x2, primeiro # se o contador for 1 vai pra função que guarda o primeiro digito
    beq  x10, x13, segundo  # se o contador for 2 vai pra função que guarda o segundo digito 
    beq  x10, x9, terceiro  # se o contador for 3 vai pra função que guarda o terceiro digito

primeiro:
    addi x14, x11, 0 # passando o primeiro digito pro x14
    beq x3,x3, get #volta pro get

segundo:
    addi x15, x11, 0 # passando o segundo digito pro x15
    beq x3,x3, get #volta pro get

terceiro:
    addi x16, x11, 0 # passando o terceiro digito pro x16
    beq x3,x3, get #volta pro get



fim:
    halt 

a: .word 3
b: .word 20
c: .word 16
um: .word 1
quinze: .word 15
meia2: .word 62

zero_: .word 0
enter: .word 13
space: .word 32
tres: .word 3
dois: .word 2
dez: .word 10
cem: .word 100

zero_char: .word '0'
um_char: .word '1'