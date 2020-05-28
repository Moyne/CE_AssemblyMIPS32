	.data
	a1:	.word 3
	a2:	.word 6
	b1:	.word 4
	b2:	.word 7
	val:	.asciiz "Il valore del determinante è: "
	.text
	.globl main
	.ent main
main:
	#lettura matrice da memoria tramite 4 valori salvati separatamente
	la $t0,a1
	la $t1,b1
	la $t2,a2
	la $t3,b2
	lw $a0,($t0)
	lw $a1,($t1)
	lw $a2,($t2)
	lw $a3,($t3)
	#salvataggio nello stack di $ra
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal determinante2x2
	add $t0,$v0,$0
	#lettura dallo stack di $ra
	lw $ra,($sp)
	#deallocazione dello stack
	addi $sp,$sp,4
	#stampa
	li $v0,4
	la $a0,val
	syscall
	li $v0,1
	add $a0,$t0,$0
	syscall
	jr $ra
	.end main
	
determinante2x2:	#funzione leaf che mi calcola un determinante2x2
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