	.text										#la versione evoluta di questo programma è nell'esercizio 2
	.globl main
	.ent main
main:
	li $s0,8									#lato/base forma da disegnare
	jal printTriangle
	jal printQuad
	li $v0,10
	syscall
	.end main
	
printTriangle:									#funzione leaf che stampa un triangolo isoscele
	add $t0,$0,$0
	add $t1,$0,$0
	addi $t3,$t1,1
	print:
		beq $t3,$0,space
		li $v0,11								#stampo un *
		li $a0,42
		syscall
		addi $t3,$t3,-1
		j next
	space:
		li $v0,11								#stampo uno spazio
		li $a0,32
		syscall
	next:
		addi $t0,$t0,1
		bne $t0,$s0,print
		add $t0,$0,$0
		addi $t1,$t1,1
		addi $t3,$t1,1
		li $v0,11								#stampo un a capo
		li $a0,10
		syscall
		bne $t1,$s0,print
	
	jr $ra
	
printQuad:										#funzione leaf che stampa un quadrato
	add $t0,$0,$0
	add $t1,$0,$0
	printQ:
		li $v0,11								#stampo un *
		li $a0,42
		syscall
		addi $t0,$t0,1
		bne $t0,$s0,printQ
		add $t0,$0,$0
		addi $t1,$t1,1
		li $v0,11								#stampo un a capo
		li $a0,10
		syscall
		bne $t1,$s0,printQ
	jr $ra