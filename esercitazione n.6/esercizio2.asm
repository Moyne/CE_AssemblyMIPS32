	.data
	howmuch:	.asciiz "Si scriva il valore del lato/base della forma da disegnare: "
	.text
	.globl main
	.ent main
main:
	li $v0,4
	la $a0,howmuch
	syscall
	li $v0,5										#leggo il valore del alto/base
	syscall
	add $a0,$v0,$0									#lato/base forma da disegnare
	jal printTriangle
	jal printQuad
	li $v0,10
	syscall
	.end main
	
printTriangle:										#funzione leaf che stampa un triangolo isoscele dato come parametro il valore della base
	addi $sp,$sp,-4									#alloco lo stack
	sw $a0,($sp)
	add $t0,$0,$0									#i
	add $t1,$0,$0									#j
	addi $t3,$t1,1									#k-> numero di * da stampare in tale riga
	add $t4,$a0,$0
	print:
		beq $t3,$0,space							#se k=0 stampo uno spazio
		li $v0,11									#altrimenti stampo un * ->cod ascii=42
		li $a0,42
		syscall
		addi $t3,$t3,-1								#k--
		j next
	space:
		li $v0,11									#stampa di uno spazio ->cod ascii=32
		li $a0,32
		syscall
	next:
		addi $t0,$t0,1								#i++
		bne $t0,$t4,print							#if i!=base vado in print di nuovo( è finita la riga? )
		add $t0,$0,$0								#è finita la riga quindi i=0 per ricomiciare
		addi $t1,$t1,1								#j++
		addi $t3,$t1,1								#riaggiorno k come j+1
		li $v0,11									#stampa di un a capo ->cod ascii=10
		li $a0,10
		syscall
		bne $t1,$t4,print							#è finita tutta la matrice? j=base? se no torno a print
	lw $a0,($sp)									#mi riprendo il valore $a0(base) dallo stack
	addi $sp,$sp,4									#dealloco lo stack
	jr $ra											#return
	
printQuad:											#funzione leaf che stampa un quadrato dato come parametro il valore di un lato
	addi $sp,$sp,-4									#alloco lo stack
	sw $a0,($sp)
	add $t0,$0,$0									#i=0
	add $t1,$0,$0									#j=0
	add $t4,$a0,$0
	printQ:
		li $v0,11									#stampo un * ->cod ascii=42
		li $a0,42
		syscall
		addi $t0,$t0,1								#i++
		bne $t0,$t4,printQ							#è finita la riga? se no torno a printQ
		add $t0,$0,$0								#è finita la riga quindi i=0
		addi $t1,$t1,1								#j++
		li $v0,11									#stampo un a capo->cod ascii=10
		li $a0,10
		syscall
		bne $t1,$t4,printQ							#è finita la matrice? j=lato?
	lw $a0,($sp)
	addi $sp,$sp,4									#dealloco lo stack
	jr $ra