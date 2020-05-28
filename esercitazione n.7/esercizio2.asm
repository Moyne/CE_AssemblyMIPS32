	.data
	value:	.asciiz "What is the value: "
	.text
	.globl main
	.ent main
main:
	#lettura del valore da tastiera
	li $v0,4
	la $a0,value
	syscall
	li $v0,5
	syscall
	add $a0,$v0,$0		#metto già in $a0 il valore per prepararmi alla calcolaSuccessivo
	#allocazione stack
	addi $sp,$sp,-4
	sw $ra,($sp)
	jal calcolaSuccessivo
	#mi riprendo il valore da $v0
	add $a0,$v0,$0		#metto il valore in $a0 per prepararlo alla stampa
	#lettura dallo stack di $ra
	lw $ra,($sp)
	#deallocazione dello stack
	addi $sp,$sp,4
	#stampa
	li $v0,1
	syscall
	jr $ra
	.end main
	
calcolaSuccessivo:	#funzione leaf che calcola il successivo della sequenzaDiCollatz
	#allocazione dello stack e salvataggio del parametro
	addi $sp,$sp,-4
	sw $a0,($sp)
	#per vedere se una parola è pari o dispari la confronto con un and(per MASCHERARE i bit) con 1
	#se rimane 1 significa che è dispari (0001 dispari 10101 dispari 10010 pari ecc.)
	andi $t2,$a0,1				#and con 1 per MASCHERARE tutti i bit tranne l'ultimo
	beq $t2,1,dispari			#se la parola rimane 1 vado a dispari
	pari:
		div $v0,$a0,2			#val/2
		lw $a0,($sp)			#ripresa dallo stack del valore
		addi $sp,$sp,4			#deallocazione stack
		jr $ra
	dispari:
		mul $a0,$a0,3			#val*3+1
		addi $v0,$a0,1
		lw $a0,($sp)			#ripresa dallo stack del valore
		addi $sp,$sp,4			#deallocazione dello stack
		jr $ra