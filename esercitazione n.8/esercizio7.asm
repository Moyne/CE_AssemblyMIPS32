	RIGHE = 9
	COLONNE = 9
	.data
	matrice: .byte 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
	res:	.space 20
	.text
	.globl main
	.ent main
main: 
	li $s3, 14
	li $s4, 0
	la $a0, matrice
	la $a1,res
	li $a2,RIGHE
	li $a3,COLONNE
	addi $sp,$sp,-4
	sw $ra,($sp)
	loopgiocodellavita:
		add $s5,$a0,$0
		li $v0,1
		add $a0,$s4,$0
		syscall
		li $v0,11
		li $a0,10
		syscall
		add $a0,$s5,$0
		jal evoluzione
		add $a0,$a0,$a1
		sub $a1,$a0,$a1
		sub $a0,$a0,$a1
		addi $s4,$s4,1
		bne $s4,$s3,loopgiocodellavita
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	.end main

evoluzione:
	addi $sp,$sp,-32
	sw $ra,28($sp)
	sw $s2,24($sp)
	sw $s0,20($sp)
	sw $s1,16($sp)
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	mul $s0,$a2,$a3
	and $s1,$0,$0
	addi $s2,$0,1
	loopev:
		add $a1,$s1,$0
		jal contaVicini
		lw $a1,8($sp)
		add $t0,$s1,$a0
		add $t2,$s1,$a1
		lb $t1,($t0)
		beq $t1,1,viva
		bne $v0,3,zero
		one:
		sb $s2,($t2)
		j next
		zero:
		sb $0,($t2)
		next:
		addi $s1,$s1,1
		bne $s1,$s0,loopev
	lw $a1,8($sp)
	lw $a2,4($sp)
	lw $a3,($sp)
	add $a0,$a1,$0
	add $a1,$a2,$0
	add $a2,$a3,$0
	jal stampaMatrice
	lw $ra,28($sp)
	lw $s2,24($sp)
	lw $s0,20($sp)
	lw $s1,16($sp)
	lw $a0,12($sp)
	lw $a1,8($sp)
	lw $a2,4($sp)
	lw $a3,($sp)
	addi $sp,$sp,32
	jr $ra	
	viva:
	blt $v0,2,zero
	blt $v0,4,one
	j zero
	
stampaMatrice:
	addi $sp,$sp,-12
	sw $a0,8($sp)
	sw $a1,4($sp)
	sw $a2,($sp)
	add $t0,$0,$0
	and $t1,$0,$0
	and $t2,$0,$0
	loopStampa:
		add $t3,$t2,$a0
		lb $t4,($t3)
		beq $t4,1,printBlack
		li $v0,11
		li $a0,32
		syscall
		nextPrint:
		lw $a0,8($sp)
		addi $t2,$t2,1
		addi $t1,$t1,1
		bne $t1,$a2,loopStampa
		addi $t0,$t0,1
		and $t1,$0,$0
		li $v0,11
		li $a0,10
		syscall
		lw $a0,8($sp)
		bne $t0,$a1,loopStampa
		lw $a1,4($sp)
		lw $a2,($sp)
		addi $sp,$sp,12
		jr $ra
	printBlack:
		li $v0,11
		li $a0,43
		syscall
		j nextPrint
	
contaVicini:
	addi $sp,$sp,-16
	sw $a0,12($sp)
	sw $a1,8($sp)
	sw $a2,4($sp)
	sw $a3,($sp)
	and $v0,$0,$0
	div $a1,$a3
	mfhi $t0			#i-->indice colonna
	mflo $t3			#j-->indice riga
	addi $t1,$t0,-1
	blt $t1,0,zerocol
	col2:
	add $t6,$t1,$0
	addi $t2,$t0,1
	addi $a3,$a3,-1
	blt $a3,$t2,colminus
	row:
	addi $a3,$a3,1
	addi $t4,$t3,-1
	blt $t4,0,zerorow
	row2:
	add $t7,$t4,$0
	addi $t5,$t3,1
	addi $a2,$a2,-1
	blt $a2,$t5,rowminus
	start:
		addi $a2,$a2,1
	loop:
		mul $t8,$t7,$a3
		add $t8,$t8,$t6
		add $t8,$t8,$a0
		lb $t9,($t8)
		add $v0,$v0,$t9
		addi $t6,$t6,1
		blt $t2,$t6,nextrow
		j loop
	end:
		mul $t8,$t3,$a3
		add $t8,$t8,$t0
		add $t8,$t8,$a0
		lb $t9,($t8)
		sub $v0,$v0,$t9
		lw $a0,12($sp)
		lw $a1,8($sp)
		lw $a2,4($sp)
		lw $a3,($sp)
		addi $sp,$sp,16
		jr $ra
	nextrow:
		addi $t7,$t7,1
		add $t6,$t1,$0
		blt $t5,$t7,end
		j loop
	zerocol:
		and $t1,$0,$0
		j col2
	colminus:
		add $t2,$t0,$0
		j row
	zerorow:
		and $t4,$0,$0
		j row2
	rowminus:
		add $t5,$t3,$0
		j start