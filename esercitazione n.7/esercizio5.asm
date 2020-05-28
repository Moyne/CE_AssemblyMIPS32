.data
	a1:	.word 3
	a2:	.word 6
	a3:	.word 8
	b1:	.word 4
	b2:	.word 7
	b3:	.word 1
	c1:	.word 2
	c2:	.word 1
	c3:	.word 9
	val:	.asciiz "Il valore del determinante è: "
	.text
	.globl main
	.ent main
main:
	#lettura matrice da memoria tramite 4 valori salvati separatamente
	lw $a0,a1
	lw $a1,b1
	lw $a2,c1
	lw $a3,a2
	lw $t0,b2
	lw $t1,c2
	lw $t2,a3
	lw $t3,b3
	lw $t4,c3
	#salvataggio nello stack di $ra e degli altri parametri da passare
	addi $sp,$sp,-24
	sw $ra,20($sp)
	sw $t4,16($sp)
	sw $t3,12($sp)
	sw $t2,8($sp)
	sw $t1,4($sp)
	sw $t0,($sp)
	jal determinante3x3
	#prendo il risultato da $v0 e riprendo dallo stack ciò che ci avevo allocato
	add $t5,$v0,$0
	lw $ra,20($sp)
	lw $t4,16($sp)
	lw $t3,12($sp)
	lw $t2,8($sp)
	lw $t1,4($sp)
	lw $t0,($sp)
	#dealloco lo stack
	addi $sp,$sp,24
	#stampa
	li $v0,4
	la $a0,val
	syscall
	li $v0,1
	add $a0,$t5,$0
	syscall
	jr $ra
	.end main
	
determinante3x3: #funzione non leaf che usa 3 volte la determinante2x2 per calcolare il determinante3x3
	#lettura dei parametri dallo stack
	lw $t4,16($sp)
	lw $t3,12($sp)
	lw $t2,8($sp)
	lw $t1,4($sp)
	lw $t0,($sp)
	#allocazione stack frame
	addi $sp,$sp,-20
	#salvataggio nello stack frame dei parametri $a0-$a3 e di $ra
	sw $ra,16($sp)
	sw $a3,12($sp)
	sw $a2,8($sp)
	sw $a1,4($sp)
	sw $a0,($sp)
	# a1 x primo determinante -> t5
	add $a0,$t0,$0
	add $a1,$t1,$0
	add $a2,$t3,$0
	add $a3,$t4,$0
	jal determinante2x2
	lw $a3,12($sp)				#rileggo i valori da $a0-$a3 dallo stack poichè li ho persi
	lw $a2,8($sp)
	lw $a1,4($sp)
	lw $a0,($sp)
	mul $t5,$v0,$a0
	# b1 x secondo determinante -> t6
	add $a0,$a3,$0
	add $a1,$t1,$0
	add $a2,$t2,$0
	add $a3,$t4,$0
	jal determinante2x2
	lw $a3,12($sp)				#rileggo i valori da $a0-$a3 dallo stack poichè li ho persi
	lw $a2,8($sp)
	lw $a1,4($sp)
	lw $a0,($sp)
	mul $t6,$v0,$a1
	# c1 x terzo determinante ->t7
	add $a0,$a3,$0
	add $a1,$t0,$0
	add $a2,$t2,$0
	add $a3,$t3,$0
	jal determinante2x2
	lw $a3,12($sp)				#rileggo i valori da $a0-$a3 dallo stack poichè li ho persi
	lw $a2,8($sp)
	lw $a1,4($sp)
	lw $a0,($sp)
	mul $t7,$v0,$a2
	# primo risultato meno il secondo più il terzo -> v0 come return
	sub $t5,$t5,$t6
	add $v0,$t5,$t7
	#ripresa dallo stack frame dei valori che mi servono, non prendo $a0-$a3 poichè li ho appena presi dopo la terza chiamata
	lw $ra,16($sp)
	#deallocazione stack frame
	addi $sp,$sp,20
	jr $ra
	
determinante2x2:		#funzione leaf che mi calcola un determinante2x2
	#allocazione stack frame e inserimento in esso dei parametri
	addi $sp,$sp,-16
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	#calcolo determinante (a1 x b2) - (b1 x a2)
	mul $a0,$a0,$a3
	mul $a1,$a1,$a2
	sub $v0,$a0,$a1
	#ripresa dallo stack dei valori immessi in esso
	lw $a0,12($sp)
	lw $a1,8($sp)
	lw $a2,4($sp)
	lw $a3,($sp)
	#deallocazione dello stack
	addi $sp,$sp,16
	jr $ra