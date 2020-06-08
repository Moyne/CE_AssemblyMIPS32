	DIM = 5
	.data
	vet1: .word 56, 12, 98, 129, 58
	vet2: .word 1, 0, 245, 129, 12
	risultato: .space DIM
	.text
	.globl main
	.ent main
main:
	la $a0, vet1
	la $a1, vet2
	la $a2, risultato
	li $a3, DIM
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal CalcolaDistanzaH
	and $t0,$0,$0
	print:
		lb $a0,($a2)
		li $v0,1
		syscall
		addi $a2,$a2,1
		addi $t0,$t0,1
		bne $t0,DIM,print
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	.end main
	
CalcolaDistanzaH:
	addi $sp,$sp,-16
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	and $t0,$0,$0
	loop:
		lw $t1,($a0)
		lw $t2,($a1)
		bge $t2,$t1,change
		contr:
		j controlloDiff
		next:
		sb $t5,($a2)
		and $t5,$0,$0
		addi $a0,$a0,4
		addi $a1,$a1,4
		addi $a2,$a2,1
		addi $t0,$t0,1
		bne $t0,$a3,loop
		lw $a0,12($sp)
		lw $a1,8($sp)
		lw $a2,4($sp)
		lw $a3,($sp)
		addi $sp,$sp,16
		jr $ra
	controlloDiff:
		andi $t3,$t1,1
		andi $t4,$t2,1
		bne $t3,$t4,diff
		nextd:
		srl $t1,$t1,1
		srl $t2,$t2,1
		bne $t1,$0,controlloDiff
		j next
	change:
		add $t1,$t1,$t2
		sub $t2,$t1,$t2
		sub $t1,$t1,$t2
		j contr
	diff:
		addi $t5,$t5,1
		j nextd