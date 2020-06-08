	NUM = 5
	DIM = NUM * 4
	SCONTO = 30
	ARROTONDA = 0
	.data
	prezzi: .word 39, 1880, 2394, 1000, 1590
	scontati: .space DIM
	.text
	.globl main
	.ent main
main: 
	la $a0, prezzi
	la $a1, scontati
	li $a2, NUM
	li $a3, SCONTO
	li $t0, ARROTONDA
	addi $sp, $sp,-8
	sw $ra,4($sp)
	sw $t0, ($sp)
	jal calcola_sconto
	add $a0,$v0,$0
	li $v0,1
	syscall
	lw $t0,($sp)
	lw $ra,4($sp)
	addi $sp, $sp,8
	jr $ra
	.end main
	
	
calcola_sconto:
	lw $t5,($sp)
	addi $sp,$sp,-16
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	addi $t4,$0,100
	sub $t0,$t4,$a3
	and $t6,$0,$0
	and $t1,$0,$0
	loop:
		lw $t2,($a0)
		add $t6,$t6,$t2
		mul $t2,$t2,$t0
		div $t3,$t2,100
		mfhi $t4
		bge $t4,50,arr
		carico:
			sw $t3,($a1)
			sub $t6,$t6,$t3
			addi $t1,$t1,1
			addi $a1,$a1,4
			addi $a0,$a0,4
			bne $t1,$a2,loop
			add $v0,$t6,$0
			lw $a0,12($sp)
			lw $a1,8($sp)
			lw $a2,4($sp)
			lw $a3,($sp)
			addi $sp,$sp,16
			jr $ra
		arr:
			beq $t5,1,arrot
			j carico
			arrot:
				addi $t3,$t3,1
				j carico