	.data
	orain:	.byte 12, 51
	oraout:	.byte 13, 11
	x:	.word 1
	y:	.word 40
	.text
	.globl main
	.ent main
main:
	la $a0,orain
	la $a1,oraout
	lw $a2,x
	lw $a3,y
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal costoParcheggio
	add $a0,$v0,$0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	.end main
costoParcheggio:
	addi $sp,$sp,-16
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	lb $t0,($a0)
	lb $t1,1($a0)
	lb $t2,($a1)
	lb $t3,1($a1)
	beq $t0,$t2,samehour
	addi $t0,$t0,1
	sub $t0,$t2,$t0
	mul $t0,$t0,60
	addi $t1,$t1,-60
	sub $t0,$t0,$t1
	add $t0,$t0,$t3
	div $t0,$t0,$a3
	mfhi  $t1
	bne $t1,$0,resto
	end:
		mul $v0,$t0,$a2
		lw $a0,12($sp)
		lw $a1,8($sp)
		lw $a2,4($sp)
		lw $a3,($sp)
		addi $sp,$sp,16
		jr $ra
	resto:
		addi $t0,$t0,1
		j end
	samehour:
		sub $t0,$t3,$t1
		div $t0,$t0,$a3
		mfhi $t1
		bne $t1,$0,resto
		j end
	