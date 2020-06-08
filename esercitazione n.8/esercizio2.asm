	.data
	anni:	.word 1945, 2008, 1800, 2006, 1748, 1600
	bis:	.space 6
	.text
	.globl main
	.ent main
main:
	la $a0,anni
	la $a1,bis
	li $a2,6
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal bisestile
	and $t0,$0,$0
	la $a1,bis
	printbis:
		lb $a0,($a1)
		li $v0,1
		syscall
		addi $t0,$t0,1
		addi $a1,$a1,1
		bne $t0,$a2,printbis
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	
	
bisestile:
	addi $sp,$sp,-12
	sw $a0,8($sp)
	sw $a1,4($sp)
	sw $a2,($sp)
	and $t0,$0,$0
	addi $t3,$0,1
	loopyear:
		lw $t1,($a0)
		div $t2,$t1,100
		mfhi $t2
		beq $t2,$0,issec
		div $t2,$t1,4
		mfhi $t2
		beq $t2,$0,isbis
		notbis:
			sb $0,($a1)
		new:
			addi $a0,$a0,4
			addi $a1,$a1,1
			addi $t0,$t0,1
			bne $t0,$a2,loopyear
			lw $a0,8($sp)
			lw $a1,4($sp)
			lw $a2,($sp)
			addi $sp,$sp,12
			jr $ra
		issec:
			div $t2,$t1,400
			mfhi $t2
			bne $t2,$0,notbis
			sb $t3,($a1)
			j new
		isbis:
			sb $t3,($a1)
			j new