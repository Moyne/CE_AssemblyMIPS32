	.data
	value:	.asciiz "What is the x value you want to check: "
	res:	.asciiz "The result is: "
	.text
	.globl main
	.ent main
main:

	li $v0,4
	la $a0,value
	syscall
	li $v0,5
	syscall
	#creazione del polinomio
	li $t0,4
	li $t1,2
	li $t2,-5
	li $t3,3
	li $s0,8
	li $s1, 4
	li $s2 ,27
	li $s3,9 
	li $s4,64
	li $s5,16
	#p(1)
	add $a0,$t0,$t1
	add $t4,$t2,$t3
	add $a0,$a0,$t4
	#p(2)
	mul $a1,$t0,$s0
	mul $t4,$t1,$s1
	add $a1,$a1,$t4
	sll $t4,$t2,1
	add $t4,$t4,$t3
	add $a1,$a1,$t4
	#p(3)
	mul $a2,$t0,$s2
	mul $t4,$t1,$s3
	add $a2,$a2,$t4
	mul $t4,$t2,3
	add $t4,$t4,$t3
	add $a2,$a2,$t4
	#p(4)
	mul $a3,$t0,$s4
	mul $t4,$t1,$s5
	add $a3,$a3,$t4
	sll $t4,$t2,2
	add $t4,$t4,$t3
	add $a3,$a3,$t4
	#allocazione dello stack
	addi $sp,$sp,-24
	#caricamento nello stack di $ra e degli altri parametri
	sw $ra,20($sp)
	sw $t0,16($sp)
	sw $t1,12($sp)
	sw $t2,8($sp)
	sw $t3,4($sp)
	sw $v0,($sp)
	jal polinomio
	#lettura del risultato in $t4, per poi passarlo a $a0 per la scrittura con la syscall
	add $t4,$v0,$0
	#rilettura dei dati dallo stack
	lw $ra,20($sp)
	lw $t0,16($sp)
	lw $t1,12($sp)
	lw $t2,8($sp)
	lw $t3,4($sp)
	lw $v0,($sp)
	#deallocazione dello stack
	addi $sp,$sp,24
	#stampa
	li $v0,4
	la $a0,res
	syscall
	li $v0,1
	add $a0,$t4,$0
	syscall
	jr $ra
	.end main
	
polinomio:			#procedura leaf che calcola il valore di un polinomio dato un N>4
	#lettura N
	lw $t4,($sp)
	#allocazione dello stack
	addi $sp,$sp,-24
	#salvataggio nello stack delle variabili callee save
	sw $s0,20($sp)
	sw $s1,16($sp)
	sw $s2,12($sp)
	sw $s3,8($sp)
	sw $s4,4($sp)
	sw $s5,($sp)
	addi $t4,$t4,-4		  #N-4
	ble $t4,0,err		  #if(N-4<=0) errore
	and $t5,$0,$0
	sub $t0,$a1,$a0
	sub $t1,$a2,$a1
	sub $t2,$a3,$a2
	sub $s0,$t1,$t0
	sub $s1,$t2,$t1
	sub $s2,$s1,$s0
	add $v0,$a3,$0
	ciclo:
		add $s1,$s1,$s2
		add $t2,$t2,$s1
		add $v0,$v0,$t2
		addi $t5,$t5,1
		bne $t5,$t4,ciclo
end:
	#lettura dello stack
	lw $s0,20($sp)
	lw $s1,16($sp)
	lw $s2,12($sp)
	lw $s3,8($sp)
	lw $s4,4($sp)
	lw $s5,($sp)
	#deallocazione dello stack
	addi $sp,$sp,24
	jr $ra
err:
	#if err return -1
	addi $v0,$0,-1
	j end
	