	RIGHE = 4
	COLONNE = 5
	.data
	matrice: .byte 0, 1, 3, 6, 2, 7, 13, 20, 12, 21, 11, 22, 10, 23, 9, 24, 8, 25, 43, 62
	.text
	.globl main
	.ent main
main: 
	la $a0, matrice
	li $a1, 19
	li $a2, RIGHE
	li $a3, COLONNE
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal contaVicini
	add $a0,$v0,$0
	li $v0,1
	syscall
	lw $ra,($sp)
	addi $sp,$sp,4
	jr $ra
	.end main
	
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